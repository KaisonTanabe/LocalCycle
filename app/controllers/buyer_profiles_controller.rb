class BuyerProfilesController < ApplicationController
  # GET /buyer_profiles
  # GET /buyer_profiles.json
  def index
    @buyer_profiles = BuyerProfile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @buyer_profiles }
    end
  end

  # GET /buyer_profiles/1
  # GET /buyer_profiles/1.json
  def show
    @buyer_profile = BuyerProfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @buyer_profile }
    end
  end

  # GET /buyer_profiles/new
  # GET /buyer_profiles/new.json
  def new
    @buyer_profile = BuyerProfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @buyer_profile }
    end
  end

  # GET /buyer_profiles/1/edit
  def edit
    @buyer_profile = BuyerProfile.find(params[:id])
  end

  # POST /buyer_profiles
  # POST /buyer_profiles.json
  def create
    @buyer_profile = BuyerProfile.new(params[:buyer_profile])

    respond_to do |format|
      if @buyer_profile.save
        format.html { redirect_to @buyer_profile, notice: 'Buyer profile was successfully created.' }
        format.json { render json: @buyer_profile, status: :created, location: @buyer_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @buyer_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /buyer_profiles/1
  # PUT /buyer_profiles/1.json
  def update
    @buyer_profile = BuyerProfile.find(params[:id])

    respond_to do |format|
      if @buyer_profile.update_attributes(params[:buyer_profile])
        format.html { redirect_to @buyer_profile, notice: 'Buyer profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @buyer_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buyer_profiles/1
  # DELETE /buyer_profiles/1.json
  def destroy
    @buyer_profile = BuyerProfile.find(params[:id])
    @buyer_profile.destroy

    respond_to do |format|
      format.html { redirect_to buyer_profiles_url }
      format.json { head :no_content }
    end
  end
end
