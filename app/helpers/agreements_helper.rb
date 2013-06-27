module AgreementsHelper
  def parsed_params
    new_params = {}
    new_params[:name]=params[:name] unless params[:name].blank?
    new_params[:price]=params[:price] unless params[:price].blank?
    new_params[:quantity]=params[:quantity] unless params[:quantity].blank?
    new_params[:duration]=params[:duration] unless params[:duration].blank?
    new_params[:show_agreements]=params[:show_agreements] unless params[:show_agreements].blank?

    new_params[:per_page]=params[:per_page] unless params[:per_page].blank?
    new_params
  end

  def full_params
    new_params = {}
    new_params[:name]=params[:name] unless params[:name].blank?
    new_params[:price]=params[:price] unless params[:price].blank?
    new_params[:quantity]=params[:quantity] unless params[:quantity].blank?
    new_params[:duration]=params[:duration] unless params[:duration].blank?
    new_params[:show_agreements]=params[:show_agreements] unless params[:show_agreements].blank?

    new_params[:sort]=params[:sort] unless params[:sort].blank?
    new_params[:direction]=params[:direction] unless params[:direction].blank?

    new_params[:per_page]=params[:per_page] unless params[:per_page].blank?
    new_params
  end
end
