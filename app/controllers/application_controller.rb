class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, alert: exception.message
  end

  def after_sign_in_path_for(resource)
    products_path
  end


  def my_agreements_path(time="")    
    current_user.producer? ? agreements_path(producer_id: current_user.id, status: time) : agreements_path(buyer_id: current_user.id, status: time)
  end
end
