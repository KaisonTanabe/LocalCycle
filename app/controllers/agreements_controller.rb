class AgreementsController < ApplicationController
  load_and_authorize_resource

  def index
    redirect_to new_buyer_profile_path and return if current_user.buyer? and !current_user.buyer_profile
    redirect_to new_producer_profile_path and return if current_user.producer? and !current_user.producer_profile

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @agreements }
    end
  end

  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @agreement }
    end
  end

  def new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @agreement }
    end
  end

  def edit
  end

  def create

    respond_to do |format|
      if @agreement.save
        format.html { redirect_to @agreement, notice: 'Agreement was successfully created.' }
        format.json { render json: @agreement, status: :created, location: @agreement }
      else
        format.html { render action: "new" }
        format.json { render json: @agreement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @agreement.update_attributes(params[:agreement])
        format.html { redirect_to @agreement, notice: 'Agreement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @agreement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @agreement.destroy

    respond_to do |format|
      format.html { redirect_to agreements_url }
      format.json { head :no_content }
    end
  end
end
