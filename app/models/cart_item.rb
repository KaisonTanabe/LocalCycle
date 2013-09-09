class CartItem < ActiveRecord::Base
  before_save :calculate_price
  after_create :calculate_price
  
  attr_accessible :quantity, :sort_order, :cart_id, :good_id, :market_id, :price, :order_id
  
  belongs_to :market
  belongs_to :good
  belongs_to :cart
  belongs_to :order
  
  private 
  
  def calculate_price
    return if cart_id == nil
    price_point = Hash.new 
		good.price_points.each do |pp|		
			if JSON.parse(pp.buyers)["#{market.id.to_s}"] != nil
				 if (JSON.parse(pp.buyers)["#{market.id.to_s}"].count == 0 )
					 price_point["#{pp.quantity.to_s}"] = pp if price_point["#{pp.quantity.to_s}"] == nil
				else
						 if (JSON.parse(pp.buyers)["#{market.id.to_s}"].include? ("#{cart.user.id.to_s}"))
								 price_point["#{pp.quantity.to_s}"] = pp 
						end
				end			
			end
		end				
	
		
		 price_point.keys.sort.each do |key|
			 pp = price_point[key]
			 if (quantity >= key.to_i)
			   self.price = pp.price 
		   end
		end
  end
  
end
