class ProductsController < ApplicationController
  load_and_authorize_resource

  helper_method :sort_column, :sort_direction
  
  require 'csv'

  # GET /products
  # GET /products.json
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  def pic
    respond_to do |format|
      format.js {}
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def export 
    products = filter_and_sort(@products, params)

    filename = "products_#{Date.today.strftime('%b-%d-%y')}"
    csv_data = CSV.generate do |csv|
      csv << Product.csv_header
      products.each do |t|
        csv << t.to_csv
      end
    end
    send_data csv_data,
      :type => 'text/csv; charset=iso-8859-1; header=present',
      :disposition => "attachment; filename=#{filename}.csv"
  end

  private

  def filter_and_sort(products, params)
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
