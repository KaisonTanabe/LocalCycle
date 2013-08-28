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
    super
  end

  def update
    super
  end

end
