class ProducerProfilesController < ApplicationController
  load_and_authorize_resource

  def new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @producer_profile }
    end
  end


  def create
    
    respond_to do |format|
      if @producer_profile.save
        format.html { redirect_to agreements_path, notice: 'Producer profile was successfully created.' }
        format.json { render json: @producer_profile, status: :created, location: @producer_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @producer_profile.errors, status: :unprocessable_entity }
      end
    end
  end
end
