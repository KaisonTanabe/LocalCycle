class SessionsController < Devise::SessionsController

  prepend_before_filter :check_activation!, :only => :create
  

  def create
    super
  end
  
  
  def check_activation!
    if User.find(:first, :conditions => ["email = lower(?)", params[:user][:email]]) !=nil && !User.find(:first, :conditions => ["email = lower(?)", params[:user][:email]]).activated 
      set_flash_message(:notice, :inactive) 
      redirect_to "/login"
    end
  end
  

end
