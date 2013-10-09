class RegistrationsController < Devise::RegistrationsController
  layout :false

  def new
    @role = "producer"
    @role = params["role"] if params["role"] and REGISTERABLE_ROLES.include?(params["role"])
    super
  end

  def create
    # add custom create logic here
    @role = "market_manager"

    # Make sure user is a registerable role. If not set to market_manager
    if params["user"]["role"] and REGISTERABLE_ROLES.include?(params["user"]["role"])
      @role = params["user"]["role"]
    else
      params["user"]["role"] = @role
    end
    build_resource(sign_up_params)

     if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      flash[:error] = "Invalid user. Cannot create account."
      
      redirect_to :back
    end
  end

  def update
    super
  end

end
