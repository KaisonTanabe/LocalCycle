module AgreementsHelper
  def my_agreements_path(time="")
    
    current_user.producer? ? agreements_path(producer_id: current_user.id, status: time) : agreements_path(buyer_id: current_user.id, status: time)
  end
end
