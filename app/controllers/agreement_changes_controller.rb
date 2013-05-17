class AgreementChangesController < ApplicationController
  load_and_authorize_resource

  def new

    respond_to do |format|
      format.html 
      format.json { render json: @agreement_change }
    end
  end


  def create
    @agreement_change.agreement_id = params["agreement_id"]
    @agreement_change.producer_id = current_user.profile_id if current_user.producer?
    @agreement_change.buyer_id = current_user.profile_id if current_user.buyer?

    respond_to do |format|
      if @agreement_change.save
        format.html { redirect_to agreements_path, notice: 'Agreement amendments successfully proposed.' }
        format.json { render json: @agreement_change, status: :created, location: @agreement_change }
      else
        format.html { render action: "new" }
        format.json { render json: @agreement_change.errors, status: :unprocessable_entity }
      end
    end
  end

  def update #Agreed!
    @agreement_change.producer_id = current_user.profile_id if current_user.producer?
    @agreement_change.buyer_id = current_user.profile_id if current_user.buyer?

    @agreement_change.agreement.mark_complete(@agreement_change.buyer_id, @agreement_change.producer_id)

    respond_to do |format|
      if @agreement_change.save
        format.html { redirect_to agreements_path, notice: 'Agreement amendments successfully proposed.' }
        format.json { render json: @agreement_change, status: :created, location: @agreement_change }
      else
        format.html { render action: "new" }
        format.json { render json: @agreement_change.errors, status: :unprocessable_entity }
      end
    end
  end
end
