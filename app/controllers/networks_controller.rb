class NetworksController < ApplicationController
  # Initialize Cancan authorization for this controller
  load_and_authorize_resource

  helper_method :sort_column, :sort_direction
  
  require 'csv'

  def index 
    @networks = filter_and_sort(@networks, params)
    @networks = @networks.paginate(page: params[:page], per_page: (params[:per_page] || DEFAULT_PER_PAGE))

    @first_login = (params[:first_login] == "true")
   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @networks }
    end
  end


  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @network }
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
      format.json { render json: @network }
    end
  end

  def create
    respond_to do |format|
      if @network.save
        format.html { redirect_to networks_path, notice: 'Network successfully created.' }
        format.json { render json: @network, status: :created, location: @network }
        format.js { render :create }
        
      else
        format.html { render action: "new" }
        format.json { render json: @network.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update

    respond_to do |format|
      if @network.update_attributes(params[:network])
        format.html { redirect_to networks_path, notice: 'Netowrk was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @network.errors, status: :unprocessable_entity }
      end
    end
  end  

  def markets_for
    format.json { render json:@network.markets }
    
  end
  
  def destroy
    id = @network.id
    @network.destroy

    UserNetwork.where(:network_id => id).each do |rm|
      UserNetwork.delete(rm)
    end
    
    respond_to do |format|
      format.html { redirect_to networks_url(params.to_hash) }
      format.json { head :no_content }
    end
  end



  def export 
    @networks = filter_and_sort(@networks, params)

    filename = "networks_#{Date.today.strftime('%d%b%y')}"
    csv_data = CSV.generate do |csv|
      csv << Network.csv_header
      @networks.each do |s|
        csv << s.to_csv
      end
    end
    send_data csv_data,
      :type => 'text/csv; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{filename}.csv"
  end






  private

  def filter_and_sort(networks, params)
    networks = networks.by_name(params[:name]) unless params[:name].blank?

    return networks.order(sort_column + " " + sort_direction)
  end
  
  def sort_column
    sort = params[:sort] || ''
    Network.column_names.include?(sort) ? sort : "name"
  end

  def sort_direction
    direction = params[:direction] || ''
    "ASC DESC".include?(direction) ? direction : "ASC"
  end
end
