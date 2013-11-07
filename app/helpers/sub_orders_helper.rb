module SubOrdersHelper
  def parsed_params
    new_params = {}
    new_params[:key]= "#{params[:order_id] }_#{('a'..'z').to_a[params[:key].to_i]}" unless params[:key].blank?
    new_params[:total]=params[:total] unless params[:total].blank?
    new_params[:created_at]=params[:created_at] unless params[:created_at].blank?
    new_params[:producer_id]= User.find(params[:producer_id]).full_name unless params[:producer_id].blank?

    new_params[:per_page]=params[:per_page] unless params[:per_page].blank?
    new_params
  end
end