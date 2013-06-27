class AgreementsController < ApplicationController
  load_and_authorize_resource

  helper_method :sort_column, :sort_direction
  
  require 'csv'

  def table

    @agreements = @agreements.available_supply_or_mine(current_user.id) if current_user.buyer?
    @agreements = @agreements.available_demand_or_mine(current_user.id) if current_user.producer?
    @agreements = filter_and_sort(@agreements, params)
    
    @agreements = @agreements.paginate(page: params[:page], per_page: (params[:per_page] || DEFAULT_PER_PAGE))

    respond_to do |format|
      format.html 
      format.json { render json: @agreements }
    end
  end

  def index
    # Ensure profile has been created
    redirect_to edit_user_path(current_user) and return unless current_user.complete

    # Popup help on first login
    @first_login = (params[:first_login] == "true")

    if current_user.buyer? and params["show_agreements"].blank?

      @products = filter_and_sort_products(Product.scoped.includes(:agreements), params) if params["show_agreements"].blank?
      @products = @products.paginate(page: params[:page], per_page: (params[:per_page] || DEFAULT_PER_PAGE)) if params["show_agreements"].blank?

    else

      if params[:status].blank?
        @agreements = (current_user.producer? ? @agreements.available_demand : @agreements.available_supply)
      else
        @agreements = @agreements.by_interacted_with_or_mine(current_user.id)
      end
      @agreements = filter_and_sort(@agreements, params)

      @agreements = @agreements.paginate(page: params[:page], per_page: (params[:per_page] || DEFAULT_PER_PAGE))
      
      @product_agreements = @agreements.group_by(&:product)

    end


    respond_to do |format|
      format.html 
      format.json { render json: @agreements }
    end
  end

  def marketplace
    @agreements = @agreements.standing_supply if current_user.buyer?
    @agreements = @agreements.standing_mine(current_user.id) if current_user.producer?
    @agreements = filter_and_sort(@agreements, params)
    @agreements = @agreements.paginate(page: params[:page], per_page: (params[:per_page] || DEFAULT_PER_PAGE))

    @product_agreements = @agreements.group_by(&:product)

    respond_to do |format|
      format.html
      format.json { render json: @agreements }
    end
  end


  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @agreement }
    end
  end

  def modal

    respond_to do |format|
      format.js
    end
  end

  def root_agreement_changes

    respond_to do |format|
      format.js
    end
  end

  def new
    @agreement.agreement_type = params[:agreement_type] unless params[:agreement_type].nil?
    @image = @agreement.images.build

    if current_user.delivery_windows.any? 
      current_user.delivery_windows.each do |dw|
        @agreement.delivery_windows.build(weekday: dw.weekday, start_hour: dw.start_hour, end_hour: dw.end_hour, transport_by: dw.transport_by)
      end
    else
      @agreement.delivery_windows.build
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @agreement }
    end
  end

  def edit
  end

  def create
    @agreement.images.build(image: @agreement.product.best_pic) unless params[:agreement][:images_attributes] if @agreement.product

    @agreement.agreement_type = (params[:agreement][:agreement_type] == "1" ? "indefinite" :  "seasonal") unless (@agreement.agreement_type == "onetime")

    @agreement.creator_id = current_user.id
    @agreement.buyer_id = current_user.id if current_user.buyer?
    @agreement.producer_id = current_user.id if current_user.producer?

    respond_to do |format|
      if @agreement.save
        format.html { redirect_to agreements_path, notice: 'Agreement was successfully created.' }
        format.json { render json: @agreement, status: :created, location: @agreement }
      else
        format.html { render action: "new" }
        format.json { render json: @agreement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @agreement.update_attributes(params[:agreement])
        format.html { redirect_to agreements_path, notice: 'Agreement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @agreement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @agreement.destroy

    respond_to do |format|
      format.html { redirect_to agreements_url }
      format.json { head :no_content }
    end
  end

  private

  def filter_and_sort_products(products, params)
    products = products.by_category_name(params[:category]) unless params[:category].blank?
    products = products.in_category(params[:cat_id]) unless params[:cat_id].blank?

    products = products.by_name(params[:name]) unless params[:name].blank?
    products = products.available_supply_only unless params[:show_available].blank?

    return products.order(sort_product_column + " " + sort_direction)
  end

  def filter_and_sort(agreements, params)

    agreements = agreements.by_name(params[:name]) unless params[:name].blank?
    agreements = agreements.in_month(params[:month]) unless params[:month].blank?
    agreements = agreements.in_category(params[:cat_id]) unless params[:cat_id].blank?

    agreements = agreements.by_creator(current_user.id).by_complete if !params[:status].blank? and params[:status] == "complete"
    agreements = agreements.by_creator(current_user.id).by_not_complete if !params[:status].blank? and params[:status] == "proposed"

    agreements = agreements.by_min_price(params[:min_price]) unless params[:min_price].blank?
    agreements = agreements.by_max_price(params[:max_price]) unless params[:max_price].blank?
    agreements = agreements.by_min_quantity(params[:min_quantity]) unless params[:min_quantity].blank?
    agreements = agreements.by_max_quantity(params[:max_quantity]) unless params[:max_quantity].blank?

    if current_user.producer? 
      agreements = agreements.includes(:buyer).near(origin: [current_user.lat,current_user.lng], within: params[:distance]) unless params[:distance].blank?
    else
      agreements = agreements.includes(:producer).near(origin: [current_user.lat,current_user.lng], within: params[:distance]) unless params[:distance].blank?
    end

    # Unused
    agreements = agreements.by_buyer(params[:buyer_id]) unless params[:buyer_id].blank?
    agreements = agreements.by_producer(params[:producer_id]) unless params[:producer_id].blank?
    agreements = agreements.by_creator(params[:creator_id]) unless params[:creator_id].blank?

#    return agreements.order("producer_id ASC")
    return agreements.order(sort_column + " " + sort_direction)
  end
  
  def sort_product_column
    sort = params[:sort] || ''
    Agreement.column_names.include?(sort) ? sort : "products.name"
  end

  def sort_column
    sort = params[:sort] || ''
    Agreement.column_names.include?(sort) ? sort : "agreements.name"
  end

  def sort_direction
    direction = params[:direction] || ''
    "ASC DESC".include?(direction) ? direction : "ASC"
  end

end
