class UsersController < ApplicationController
  # Initialize Cancan authorization for this controller
  load_and_authorize_resource# except: "create"

  helper_method :sort_column, :sort_direction
  
  require 'csv'

  def index
    @user = User.new()

    @users = filter_and_sort(@users, params)
   
    if current_user.market_manager?
      remove_users = Array.new
      current_user.markets.each do |m|
        remove_users = remove_users + m.users
      end
      remove_users = remove_users.map{|m| m.id}
      
      @users = @users.where(:id=>remove_users)
    end
    
    @users = @users.paginate(page: params[:page], per_page: (params[:per_page] || DEFAULT_PER_PAGE))

    @first_login = (params[:first_login] == "true")
   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.js
    end
  end


  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
      format.js
      format.pdf do
        render :pdf => "Profile",
        layout: "pdf.html"
      end
    end
  end


  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def create
    @user = User.new(params[:user])
    puts "pPAPF"
    puts params[:user]
    puts @user.name
    
   # @user.skip_confirmation_notification!
    @user.password = "TempPass42"
    @user.password_confirmation = "TempPass42"

    respond_to do |format|
      if @user.save
        @user.name = params[:user][:name]
        @user.save
        if current_user.admin?
          @user.user_networks.each do |n|
            n.approved = true
            n.save
          end
        end
        format.html { redirect_to edit_user_path(@user), notice: 'User successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
        format.js { render :create }
      else
        format.html { redirect_to :back, notice: 'Unable to create User.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js { render :create_error }
      end
    end
  end

  def edit
    @user.markets.each do |m|
      next if @user.minimum_orders.map{|m| m.market_id}.include?(m.id)
      @user.minimum_orders.create(:market_id => m.id, :min_order=>0)
    end
    
    # Create dummy market to update if market manager

    # Initialize 4 delivery windows to encourage multiple options
    #(4 - @user.market.delivery_windows.count).times {@user.market.delivery_windows.build} if @user.market_manager?
  end

  def update
    @user.complete = true

    if @user.producer?
      params[:user][:certification_ids] ||= []
    end

#    params[:user][:category_ids] ||= []
#    params[:user][:product_ids] ||= []

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to (current_user.admin? ? users_path : goods_path), notice: ROLES[@user.role] + ' was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end  

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url(params.to_hash) }
      format.json { head :no_content }
    end
  end


  def export 
    @users = filter_and_sort(@users, params)

    filename = "users_#{Date.today.strftime('%d%b%y')}"
    csv_data = CSV.generate do |csv|
      csv << User.csv_header
      @users.each do |s|
        csv << s.to_csv
      end
    end
    send_data csv_data,
      :type => 'text/csv; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{filename}.csv"
  end


  def activate
    @user.update_attribute(:activated, true);
    Devise::Mailer.confirmation_instructions(@user).deliver
    render :nothing => true
  end

  def approve_network
    network_id = params[:network_id]
    @user.user_networks.where(:network_id => network_id).first.update_attribute(:approved, true) 
    render :nothing => true
    
  end
  
  def remove_network
    network_id = params[:network_id]
    UserNetwork.delete(@user.user_networks.where(:network_id => network_id).first.id)
    render :nothing => true

  end
  


  private

  def filter_and_sort(users, params)
    users = users.by_name(params[:name]) unless params[:name].blank?
    users = users.by_role(params[:role]) unless params[:role].blank?

    return users.order(sort_column + " " + sort_direction)
  end
  
  def sort_column
    sort = params[:sort] || ''
    User.column_names.include?(sort) ? sort : "last_name"
  end

  def sort_direction
    direction = params[:direction] || ''
    "ASC DESC".include?(direction) ? direction : "ASC"
  end
end
