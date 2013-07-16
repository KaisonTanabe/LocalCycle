class GoodsController < ApplicationController
  load_and_authorize_resource

  helper_method :sort_column, :sort_direction
  
  require 'csv'

  def index
    # Ensure profile has been created
    redirect_to edit_user_path(current_user) and return unless current_user.complete

    @good = Good.new()

    @goods = @goods.includes(:product, :selling_units)
    @goods = filter_and_sort(@goods, params)
    @goods = @goods.paginate(page: params[:page], per_page: (params[:per_page] || DEFAULT_PER_PAGE))

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @goods }
    end
  end

  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @good }
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
  end


  def create

    respond_to do |format|
      if @good.save
        format.html { redirect_to goods_url, notice: 'Good was successfully created.' }
        format.json { render json: @good, status: :created, location: @good }
        format.js { render :create }
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
        format.html { redirect_to goods_url, notice: 'Good was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @good.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @good.destroy

    respond_to do |format|
      format.html { redirect_to goods_url }
      format.json { head :no_content }
    end
  end


  def export 
    goods = filter_and_sort(@goods, params)

    filename = "goods_#{Date.today.strftime('%b-%d-%y')}"
    csv_data = CSV.generate do |csv|
      csv << Good.csv_header
      goods.each do |t|
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
    goods = goods.by_name(params[:name]) unless params[:name].blank?
    goods = goods.by_category(params[:category]) unless params[:category].blank?
    goods = goods.by_product(params[:product]) unless params[:product].blank?
    goods = goods.in_category(params[:cat_id]) unless params[:cat_id].blank?

    return goods.order(sort_column + " " + sort_direction)
  end
  
  def sort_column
    sort = params[:sort] || ''
    (Good.column_names.include?(sort) || sort == "selling_units.name" || sort == "categories.name") ? sort : "goods.name"
  end

  def sort_direction
    direction = params[:direction] || ''
    "ASC DESC".include?(direction) ? direction : "ASC"
  end
end
