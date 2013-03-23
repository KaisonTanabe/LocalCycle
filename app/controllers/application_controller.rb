class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_view_subdomain
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, alert: exception.message
  end

  # Hokay. Soh... This is the biggest hack I may have ever done...
  # I have usurped Rails locale handlers for my own nefarious purposes.
  # I can now do things like override view files with files that include
  #  my SUBDOMAIN in the file name... As if it was a locale... WIN!
  def set_view_subdomain
    I18n.locale = SUBDOMAIN
    I18n.backend.class.send(:include, I18n::Backend::Fallbacks)
    I18n.fallbacks.map(SUBDOMAIN => 'en')
  end

  def after_sign_in_path_for(resource)
    forms_path
  end

end
