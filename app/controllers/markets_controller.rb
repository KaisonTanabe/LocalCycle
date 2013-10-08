class MarketsController < ApplicationController
  # Initialize Cancan authorization for this controller
  load_and_authorize_resource

  helper_method :sort_column, :sort_direction
  
  require 'csv'

  def index 
    @markets = filter_and_sort(@markets, params)
    @markets = @markets.paginate(page: params[:page], per_page: (params[:per_page] || DEFAULT_PER_PAGE))

    @first_login = (params[:first_login] == "true")
   
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @markets }
    end
  end


  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @market }
      format.js
      format.pdf do
        render :pdf => "Profile",
        layout: "pdf.html"
      end
    end
  end


  
  def buyers_for
    format.json { render json: @market.users }
    
  end
  

  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @market }
    end
  end

  def create
    respond_to do |format|
      if @market.save
        if current_user.market_manager?
          current_user.markets << @market
          current_user.save
        end
        
        format.html { redirect_to  markets_path, notice: 'Market successfully created.' }
        format.json { render json: @market, status: :created, location: @market }
        format.js { render :create }
        
      else
        format.html { render action: "new" }
        format.json { render json: @market.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @market.delivery_windows.build
  end

  def update

    respond_to do |format|
      if @market.update_attributes(params[:market])
        format.html { redirect_to markets_path, notice: 'Market was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @market.errors, status: :unprocessable_entity }
      end
    end
  end  

  def destroy
    @market.destroy

    respond_to do |format|
      format.html { redirect_to markets_url(params.to_hash) }
      format.json { head :no_content }
    end
  end



  def export 
    @markets = filter_and_sort(@markets, params)

    filename = "markets_#{Date.today.strftime('%d%b%y')}"
    csv_data = CSV.generate do |csv|
      @markets.each do |s|
        csv << s.to_csv
      end
    end
    send_data csv_data,
      :type => 'text/csv; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{filename}.csv"
  end






  private

  def filter_and_sort(markets, params)
    markets = markets.by_name(params[:name]) unless params[:name].blank?

    return markets.order(sort_column + " " + sort_direction)
  end
  
  def sort_column
    sort = params[:sort] || ''
    Market.column_names.include?(sort) ? sort : "name"
  end

  def sort_direction
    direction = params[:direction] || ''
    "ASC DESC".include?(direction) ? direction : "ASC"
  end
end
