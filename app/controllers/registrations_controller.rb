class RegistrationsController < Devise::RegistrationsController

  def new
    @role = "producer"
    @role = params["role"] if params["role"] and REGISTERABLE_ROLES.include?(params["role"])
    super
  end

  def create
    # add custom create logic here
    @role = "producer"
    @role = params["user"]["role"] if params["user"]["role"] and REGISTERABLE_ROLES.include?(params["user"]["role"])
    super
  end

  def update
    super
  end

end
