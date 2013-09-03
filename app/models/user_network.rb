class UserNetwork < ActiveRecord::Base
   attr_accessible :user_id, :network_id, :approved
   belongs_to :user
   belongs_to :network
   
   validates :user_id, :network_id,  presence: true
   
   def destroy
    self.network.markets.each do |market|
      self.user.markets.delete(Market.find(market.id))
    end
    
    super
   end
   
end
