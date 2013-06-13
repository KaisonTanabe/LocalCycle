class AgreementChangesController < ApplicationController
  load_and_authorize_resource

  def new
    @agreement = Agreement.find(params["agreement_id"])

    respond_to do |format|
      format.html 
      format.json { render json: @agreement_change }
    end
  end

  def create
    @agreement = Agreement.find(params["agreement_id"])

    @agreement_change.agreement_id = params["agreement_id"]
    @agreement_change.user_id = current_user.id
    @agreement_change.status = "pending"

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

  def chain
    @agreement = Agreement.find(params["agreement_id"])

    one_id, two_id = params[:user_ids].split(':')
    @agreement_changes = @agreement.agreement_changes.where("user_id = ? OR user_id = ?", one_id, two_id)

    respond_to do |format|
      format.html 
      format.json
      format.js
    end
  end

  def update #Hijacked for Agreed and Reject
    @agreement = Agreement.find(params["agreement_id"])

    respond_to do |format|
      if @agreement_change.update_attributes(params[:agreement_change])
        @agreement.mark_complete(@agreement_change) if @agreement_change.agreed?
        @agreement_change.terminate_chain if @agreement_change.terminated?
        format.html { redirect_to agreements_path, notice: 'Agreement amendments successfully proposed.' }
        format.json { render json: @agreement_change, status: :created, location: @agreement_change }
      else
        format.html { render action: "new" }
        format.json { render json: @agreement_change.errors, status: :unprocessable_entity }
      end
    end
  end
end
