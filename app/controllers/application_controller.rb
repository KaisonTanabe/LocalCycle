class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, alert: exception.message
  end

  def after_sign_in_path_for(resource)
    agreements_path
  end


  def my_products_path(time="")    
    current_user.producer? ? products_path(producer: current_user.id, status: time) : products_path(buyer: current_user.id, status: time)
  end
end
