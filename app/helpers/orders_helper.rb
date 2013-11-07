module OrdersHelper
  def parsed_params

    new_params = {}
    new_params[:id]=params[:id] unless params[:id].blank?

    new_params[:created_at]=params[:created_at] unless params[:created_at].blank?
    new_params[:user]= User.find(params[:user_id]).full_name unless params[:user_id].blank?

    new_params[:per_page]=params[:per_page] unless params[:per_page].blank?
    new_params
  end
end