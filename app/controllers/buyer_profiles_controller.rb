class BuyerProfilesController < ApplicationController
  load_and_authorize_resource

  def new
    @delivery_window = @buyer_profile.delivery_windows.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @buyer_profile }
    end
  end


  def create
    @buyer_profile.user_id = current_user.id

    respond_to do |format|
      if @buyer_profile.save
        format.html { redirect_to agreements_path(first_login: true), notice: 'Buyer profile was successfully created.' }
        format.json { render json: @buyer_profile, status: :created, location: @buyer_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @buyer_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end
end
