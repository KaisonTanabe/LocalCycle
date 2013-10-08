class UserNetwork < ActiveRecord::Base
   attr_accessible :user_id, :network_id, :approved
   belongs_to :user
   belongs_to :network
   
   validates :user_id, :network_id,  presence: true
   validates :network_id,:uniqueness => { scope: :user_id }
   
   def destroy
    self.network.markets.each do |market|
      self.user.markets.delete(Market.find(market.id))
    end
    
    super
   end
   

   
end
