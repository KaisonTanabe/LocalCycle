class UsersController < ApplicationController
  # Initialize Cancan authorization for this controller
  load_and_authorize_resource

  helper_method :sort_column, :sort_direction
  
  require 'csv'

  def index 
    @users = filter_and_sort(@users, params)
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
    end
  end


  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def create
    respond_to do |format|
      if @user.save
        format.html { redirect_to teams_user_path(@user), notice: USER_LABEL.capitalize + ' was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @attachment = @user.attachments.build
  end

  def update
    params[:user][:producer_profile_attributes][:certification_ids] ||= []

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to current_user.admin? ? users_path : agreements_path, notice: @user.role.capitalize + ' was successfully updated.' }
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
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def done
    @user = User.find(params[:id]) if can?
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






  private

  def filter_and_sort(users, params)
    users = users.active_only unless params[:include_inactives] == "true"

    users = users.by_name(params[:name]) unless params[:name].blank?

    users = users.by_seen(false) if params[:status] and (params[:status] == "unseen")

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
