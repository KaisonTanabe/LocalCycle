class ProducerProfilesController < ApplicationController
  # GET /producer_profiles
  # GET /producer_profiles.json
  def index
    @producer_profiles = ProducerProfile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @producer_profiles }
    end
  end

  # GET /producer_profiles/1
  # GET /producer_profiles/1.json
  def show
    @producer_profile = ProducerProfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @producer_profile }
    end
  end

  # GET /producer_profiles/new
  # GET /producer_profiles/new.json
  def new
    @producer_profile = ProducerProfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @producer_profile }
    end
  end

  # GET /producer_profiles/1/edit
  def edit
    @producer_profile = ProducerProfile.find(params[:id])
  end

  # POST /producer_profiles
  # POST /producer_profiles.json
  def create
    @producer_profile = ProducerProfile.new(params[:producer_profile])

    respond_to do |format|
      if @producer_profile.save
        format.html { redirect_to @producer_profile, notice: 'Producer profile was successfully created.' }
        format.json { render json: @producer_profile, status: :created, location: @producer_profile }
      else
        format.html { render action: "new" }
        format.json { render json: @producer_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /producer_profiles/1
  # PUT /producer_profiles/1.json
  def update
    @producer_profile = ProducerProfile.find(params[:id])

    respond_to do |format|
      if @producer_profile.update_attributes(params[:producer_profile])
        format.html { redirect_to @producer_profile, notice: 'Producer profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @producer_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /producer_profiles/1
  # DELETE /producer_profiles/1.json
  def destroy
    @producer_profile = ProducerProfile.find(params[:id])
    @producer_profile.destroy

    respond_to do |format|
      format.html { redirect_to producer_profiles_url }
      format.json { head :no_content }
    end
  end
end
