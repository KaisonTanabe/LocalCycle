class ProducerProfilesController < ApplicationController
  load_and_authorize_resource

  def new
    @delivery_window = @producer_profile.delivery_windows.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @producer_profile }
    end
  end


  def create
    @producer_profile.user_id = current_user.id
    
    respond_to do |format|
      if @producer_profile.save
        format.html { redirect_to agreements_path(first_login: true), notice: 'Producer profile was successfully created.' }
        format.json { render json: @producer_profile, status: :created, location: @producer_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @producer_profile.errors, status: :unprocessable_entity }
      end
    end
  end
end
