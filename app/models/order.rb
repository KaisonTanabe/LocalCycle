class Order < ActiveRecord::Base
   
   attr_accessible :transaction_id, :total, :address_id, :address_attributes, :transaction_attributes, :ip_address, :status, :user_id

   belongs_to :transaction
   belongs_to :address
   belongs_to :user
   
   has_one :cart
   has_many :cart_items
   
   accepts_nested_attributes_for :transaction, :address
   
 
   def finalize_transaction auth
     transaction.amount = total
     transaction.authorization_code = auth
     transaction.save
     
     cart.cart_items.each do |item|
       item.order_id = id
       item.cart_id =nil
       item.save

       
     end
     cart.delete
     status = "COMPLETE"
     save
   end
   
   
end
