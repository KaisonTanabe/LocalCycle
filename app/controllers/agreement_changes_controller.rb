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
    @agreement_change.user_id = current_user.id

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

  def update #Hijacked for Agreed!

    @agreement_change.agreement.mark_complete(@agreement_change)

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
