module GoodsHelper
  def parsed_params
    new_params = {}
    new_params[:name]=params[:name] unless params[:name].blank?
    new_params[:price]=params[:price] unless params[:price].blank?
    new_params[:producer]=params[:producer] unless params[:producer].blank?
    new_params[:availability]=params[:availability] unless params[:availability].blank?

    new_params[:per_page]=params[:per_page] unless params[:per_page].blank?
    new_params
  end

  def full_params
    new_params = {}
    new_params[:name]=params[:name] unless params[:name].blank?
    new_params[:price]=params[:price] unless params[:price].blank?
    new_params[:producer]=params[:producer] unless params[:producer].blank?
    new_params[:availability]=params[:availability] unless params[:availability].blank?

    new_params[:sort]=params[:sort] unless params[:sort].blank?
    new_params[:direction]=params[:direction] unless params[:direction].blank?

    new_params[:per_page]=params[:per_page] unless params[:per_page].blank?
    new_params
  end
end
