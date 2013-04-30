class AgreementsController < ApplicationController
  load_and_authorize_resource

  def index
    redirect_to new_buyer_profile_path and return if current_user.buyer? and !current_user.buyer_profile
    redirect_to new_producer_profile_path and return if current_user.producer? and !current_user.producer_profile

    @agreements = filter_and_sort(@agreements, params)
    @agreements = @agreements.paginate(page: params[:page], per_page: (params[:per_page] || DEFAULT_PER_PAGE))

    @products = params["cat"].blank? ? Product.includes(:category).scoped : Product.includes(:category).where(category_id: Category.where(id: params["cat"]).first.self_and_descendant_ids)
    @products = filter_and_sort_products(@products, params)
    @products = @products.paginate(page: params[:page], per_page: (params[:per_page] || DEFAULT_PER_PAGE))

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @agreements }
    end
  end

  def marketplace

    respond_to do |format|
      format.html # marketplace.html.erb
      format.json { render json: @agreements }
    end
  end

  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @agreement }
    end
  end

  def new
    @agreement.agreement_type = params[:agreement_type] unless params[:agreement_type].nil?
    @image = @agreement.images.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @agreement }
    end
  end

  def edit
  end

  def create
    @agreement.images.build(image: @agreement.product.best_pic) unless params[:agreement][:images_attributes]
    @agreement.buyer_id == current_user.id if current_user.buyer?
    @agreement.producer_id == current_user.id if current_user.producer?

    respond_to do |format|
      if @agreement.save
        format.html { redirect_to my_agreements_path, notice: 'Agreement was successfully created.' }
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
        format.html { redirect_to @agreement, notice: 'Agreement was successfully updated.' }
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

  def filter_and_sort(agreements, params)
    
    agreements = agreements.by_name(params[:name]) unless params[:name].blank?
    agreements = agreements.by_category(params[:cat]) unless params[:cat].blank?
    agreements = agreements.by_buyer(params[:buyer_id]) unless params[:buyer_id].blank?
    agreements = agreements.by_producer(params[:producer_id]) unless params[:producer_id].blank?

    return agreements.order(sort_column + " " + sort_direction)
  end

  def filter_and_sort_products(products, params)
    products = products.by_name(params[:name]) unless params[:name].blank?
    products = products.by_category(params[:category]) unless params[:category].blank?

    return products.order(sort_product_column + " " + sort_direction)
  end
  
  def sort_product_column
    sort = params[:sort] || ''
    Product.column_names.include?(sort) ? sort : "name"
  end

  def sort_column
    sort = params[:sort] || ''
    Product.column_names.include?(sort) ? sort : "agreements.name"
  end

  def sort_direction
    direction = params[:direction] || ''
    "ASC DESC".include?(direction) ? direction : "ASC"
  end

end
