class CounterAgreementsController < ApplicationController
  load_and_authorize_resource

  def new

    respond_to do |format|
      format.js
    end
  end


  def create
    @counter_agreement.user_id = current_user.id

    @agreement = @counter_agreement.agreement

    respond_to do |format|
      if @counter_agreement.save
        format.html { redirect_to products_path, notice: 'Producer profile was successfully created.' }
        format.json { render json: @counter_agreement, status: :created, location: @counter_agreement }
        format.js { render "agreements/modal" }
      else
        format.html { render action: "new" }
        format.json { render json: @counter_agreement.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end
end
