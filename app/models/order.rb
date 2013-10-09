class Order < ActiveRecord::Base
   
   attr_accessible :transaction_id, :total, :address_id, :address_attributes, :transaction_attributes, :ip_address, :status, :user_id

   belongs_to :transaction
   belongs_to :address
   belongs_to :user
   
   has_one :cart
   has_many :cart_items
   
   accepts_nested_attributes_for :transaction, :address
   
   default_scope includes(:cart_items)
 
   def finalize_transaction auth
     
     self.transaction.amount = total
     self.transaction.authorization_code = auth
     self.transaction.save
     
     self.cart.cart_items.each do |item|
       good = item.good
       good.quantity = good.quantity - item.quantity
       good.available = false if (good.quantity ==0)
       good.save
       item.order_id = id
       item.cart_id =nil
       item.save

       
     end
     cart.delete
     self.status = "COMPLETE"
     self.save
     
   end
   
   
end
