class Order < ActiveRecord::Base
   
   attr_accessible :transaction_id, :total, :address_id, :address_attributes, :transaction_attributes, :ip_address, :status, :user_id, :producer_total

   belongs_to :transaction
   belongs_to :address
   belongs_to :user
   
   has_one :cart
   has_many :cart_items
   has_many :sub_orders
   
   accepts_nested_attributes_for :transaction, :address
   
   default_scope includes(:cart_items)
 
   def producers
    producers =cart_items.collect{|i| i.created_by}.uniq
   end
  
   def markets
    markets = sub_orders.collect{|s| s.market}.uniq
   end
   
   def finalize_transaction auth
     
     self.transaction.amount = total
     self.transaction.authorization_code = auth
     self.transaction.save
     
     
     sub_id = self.cart.cart_items.map{|i| "#{i.good.creator_id}_#{i.market_id}"}.uniq 
     
   
     sub_order_hash = Hash.new
     sub_order_totals = Hash.new
     sub_order_p_totals = Hash.new
     
     self.cart.cart_items.each do |item|
       good = item.good
       good.quantity = good.quantity - item.quantity
       good.available = false if (good.quantity ==0)
       good.save
       item.order_id = id
       
       sub_key = "#{item.good.creator_id}_#{item.market_id}"
       if(sub_order_hash.keys.include?(sub_key))
         item.sub_order_id = SubOrder.where(:order_id => id, :market_id => item.market_id, :producer_id => item.good.creator_id).first.id
         sub_order_p_totals[item.sub_order_id] =  sub_order_totals[item.sub_order_id] + (item.quantity * item.price)
         sub_order_totals[item.sub_order_id] =  sub_order_totals[item.sub_order_id] + (item.quantity * (item.price+(item.price*item.markup/100)))
         
      else
        s_o= SubOrder.create(:order_id => id, :market_id => item.market_id, :producer_id => item.good.creator_id, :key =>sub_id.index(sub_key), :dist_cost => item.market.distribution_fee, :market_date=> item.market.next_market, :delivery_window_day => (item.market.delivery_windows.first == nil ? -1 : item.market.delivery_windows.first.weekday),:delivery_window_start => (item.market.delivery_windows.first == nil ? -1 : item.market.delivery_windows.first.start_hour), :delivery_window_end => (item.market.delivery_windows.first == nil ? -1 : item.market.delivery_windows.first.end_hour))
        sub_order_hash[sub_key] = s_o.id
        item.sub_order_id =sub_order_hash[sub_key]
        sub_order_p_totals[s_o.id] =  (item.quantity * item.price)
        sub_order_totals[s_o.id] =  (item.quantity * (item.price+(item.price*item.markup/100)))

      end
       item.cart_id =nil
       item.save

       
     end
     sub_order_totals.keys.each do |so|
      som =SubOrder.find(so.to_i)
      som.update_attribute('total',  sub_order_totals[so])
      som.update_attribute('producer_total',  sub_order_p_totals[so])
      
     end
     
     cart.delete
     self.status = "COMPLETE"
     self.save
     
   end
   
   
end
