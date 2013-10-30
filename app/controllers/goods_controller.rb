require 'uri'

class GoodsController < ApplicationController
  load_and_authorize_resource

  helper_method :sort_column, :sort_direction
  
  require 'csv'

  def marketplace
    # Ensure profile has been created
    redirect_to edit_user_path(current_user) and return unless current_user.complete

    @goods = Good.scoped.includes(:product, :price_points).where(:wishlist_id => nil)
    @cat_id =  params.has_key?(:cat_id) ? params[:cat_id] : nil

    if current_user.buyer? && current_user.networks.length >0
        @network = Network.find( params.has_key?(:network_id) ? params[:network_id] : current_user.networks.first.id )
        @market = params.has_key?(:market_id) ? Market.find(params[:market_id]) : current_user.markets.where(:network_id => @network.id).first
        @goods = @goods.where("goods.start_date <= ?", Date.current).where("goods.end_date is null or goods.end_date >= ?", Date.current).where(:available => true)
    end
    @goods = filter_and_sort(@goods, params)
    @goods = @goods.paginate(page: params[:page], per_page: (params[:per_page] || DEFAULT_PER_PAGE))

    @product_goods = @goods.group_by(&:product)

    respond_to do |format|
      format.html { render (current_user.role == 'buyer' ? 'buyer_marketplace' : 'marketplace')}      
      format.json { render json: @goods }
    end
  end

  def index
    # Ensure profile has been created
    redirect_to edit_user_path(current_user) and return unless current_user.complete

    
    @good = Good.new()
    @good.price_points.build()

    @cat_id =  params.has_key?(:cat_id) ? params[:cat_id] : nil
    @goods = Good.scoped.includes(:product, :price_points).where(:wishlist_id => nil)
    
    @goods = @goods.by_creator(current_user) if current_user.producer?


    if current_user.buyer? 
        @network = Network.find( params.has_key?(:network_id) ? params[:network_id] : current_user.networks.first.id )
        @market = params.has_key?(:market_id) ? Market.find(params[:market_id]) : current_user.markets.where(:network_id => @network.id).first
        @goods = @goods.where("goods.start_date <= ?", Date.current).where("goods.end_date is null or goods.end_date >= ?", Date.current).where(:available => true)
        
    end
    
    @goods = filter_and_sort(@goods, params)
    
    if current_user.market_manager?
      remove_goods = Array.new
      current_user.markets.each do |m|
        remove_goods = remove_goods + m.goods
      end
      remove_goods = remove_goods.map{|m| m.id}
      
      @goods = @goods.where(:id=>remove_goods)
    end
    
    @goods = @goods.paginate(page: params[:page], per_page: (params[:per_page] || DEFAULT_PER_PAGE))
    
    
    respond_to do |format|
      format.html { render (current_user.role == 'buyer' ? 'buyer_index' : 'index')}
         
      
      format.json { render json: @goods }
    end
  end

  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @good }
      format.js
    end
  end


  def pic

    respond_to do |format|
      format.js {}
    end
  end


  def new
    @good = Good.new()

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @good }
    end
  end

  def edit
    render :layout => false
  end


  def create
    
    respond_to do |format|
      puts "HELLo: #{params.to_yaml}"
      if @good.save
        @good.update_markets if !current_user.buyer?
        @good.price_points.each do |p|
          if (p.producer_id != -1)
            ProducerMailer.new_demand(@good.id, current_user, p, p.producer_id).deliver if params[:good].has_key?(:wishlist_id) 
          else
            users = Array.new
            current_user.networks.each do |n|
              n.users.where(:role => 'producer').each do |pro|
                ProducerMailer.new_demand(@good.id, current_user, p, pro.id).deliver if params[:good].has_key?(:wishlist_id) && !users.include?(pro.id)
                users << pro.id
              end
            end
              
          end
          
        end
        
        
        format.html { redirect_to goods_url, notice: 'Good was successfully created.' }
        format.json { render json: @good, status: :created, location: @good }
        format.js { render (params[:good].has_key?(:wishlist_id) ? 'wishlists/create' : :create)}
      else
        format.html { render action: "new" }
        format.json { render json: @good.errors, status: :unprocessable_entity }
        format.js { render :create_error }
      end
    end
  end


  def update
    respond_to do |format|
      if @good.update_attributes(params[:good])
        Good.find(@good.id).update_markets if !current_user.buyer?
        

        
        if params[:render] == 'false'
           render :nothing=> true
           return
        end
        format.html { redirect_to (current_user.buyer? ? wishlist_url(current_user.wishlist) : goods_url), notice: 'Good was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end

  def buyer_panel
    puts "IN BUYER PANEL"
    @target_id = params[:target]
    @data = URI.unescape(params[:data])
    render :layout=>false
  end

  def destroy
    wishlist_id = @good.wishlist_id
    @good.destroy

    respond_to do |format|
      format.html { redirect_to  (wishlist_id != nil ? wishlist_path(wishlist_id) : goods_url) }
      format.json { head :no_content }
    end
  end

  def toggle_available
    @good = Good.find(params[:id])

    @good.update_column("available", !@good.available)
    
    respond_to do |format|
      format.html { redirect_to goods_url, notice: "#{@good.name} is #{@good.available ? 'now' : 'no longer'} available" }
      format.json { render json: { id: @good.id, available: @good.available, message: "#{@good.name} is #{@good.available ? 'now' : 'no longer'} available" } }
    end
  end


  def export 
    goods = filter_and_sort(@goods, params)

    filename = "goods_#{Date.today.strftime('%b-%d-%y')}"
    csv_data = CSV.generate do |csv|
      csv << Good.csv_header
      goods.includes(:product).each do |t|
        csv << t.to_csv
      end
    end
    send_data csv_data,
      :type => 'text/csv; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{filename}.csv"
  end

  def import
    if request.post? && params[:file].present?
      errs = import_records(params[:file], "good")
    end
    # Export Error file for later upload upon correction 
    if errs.any? 
      errFile = "good_errors_#{Date.today.strftime('%b-%d-%y')}.csv"
      csv_errs = CSV.generate do |csv|
        csv << Good.csv_header + ",Error"
        errs.each {|row| csv << row}
      end 
      send_data csv_errs, 
      :type => 'text/csv; charset=iso-8859-1; header=present', 
      :disposition => "attachment; filename=#{errFile}"
    else
      redirect_to goods_path, notice: "Successfully imported goods" and return
    end
  end

  private

  def filter_and_sort(goods, params)
    @search = params[:search] if(params.has_key?(:search))
    @filters = params[:filter] if(params.has_key?(:filter))
    
    #goods = goods.by_market(current_user.markets.first.id) unless current_user.admin?
    goods = goods.by_market(params[:market]) unless params[:market].blank?
    goods = goods.by_name(params[:name]) unless params[:name].blank?
    goods = goods.by_category(params[:category]) unless params[:category].blank?
    goods = goods.by_product(params[:product]) unless params[:product].blank?
    goods = goods.in_category(params[:cat_id]) unless params[:cat_id].blank?

    filtered_goods = Good.all
    
    if(params.has_key?(:filter))
      params[:filter].split(',').each do |f|
        all_certs = Certification.find(f).goods
        filtered_goods = filtered_goods & all_certs
      end
    end
    
    filtered_goods = filtered_goods.map{|m| m.id}
    
    if(params.has_key?(:search))
      if(params[:search] != '')
        goods = goods.includes(:product).where("LOWER(products.name) like LOWER('%#{URI.unescape(params[:search])}%')")
      end
    end
    
    return goods.where(:id=>filtered_goods).order(sort_column + " " + sort_direction)
  end
  
  
  def sort_column
    sort = params[:sort] || ''
    (Good.column_names.include?(sort) || sort == "selling_units.name") ? sort : "products.name"
  end

  def sort_direction
    direction = params[:direction] || ''
    "ASC DESC".include?(direction) ? direction : "ASC"
  end
end
