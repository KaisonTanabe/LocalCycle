module ProductsHelper
  def parsed_params
    new_params = {}
    new_params[:name]=params[:name] unless params[:name].blank?
    new_params[:category]=params[:category] unless params[:category].blank?
    new_params[:selling_units]=params[:selling_units] unless params[:selling_units].blank?
    new_params[:start_date]=params[:start_date] unless params[:start_date].blank?
    new_params[:end_date]=params[:end_date] unless params[:end_date].blank?

    new_params[:per_page]=params[:per_page] unless params[:per_page].blank?
    new_params
  end

  def full_params
    new_params = {}
    new_params[:name]=params[:name] unless params[:name].blank?
    new_params[:category]=params[:category] unless params[:category].blank?
    new_params[:selling_units]=params[:selling_units] unless params[:selling_units].blank?
    new_params[:start_date]=params[:start_date] unless params[:start_date].blank?
    new_params[:end_date]=params[:end_date] unless params[:end_date].blank?

    new_params[:sort]=params[:sort] unless params[:sort].blank?
    new_params[:direction]=params[:direction] unless params[:direction].blank?

    new_params[:per_page]=params[:per_page] unless params[:per_page].blank?
    new_params
  end
end
