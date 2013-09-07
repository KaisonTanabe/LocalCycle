class CartItem < ActiveRecord::Base
  attr_accessible :quantity, :sort_order, :cart_id, :good_id, :market_id
  
  belongs_to :market
  belongs_to :good
  belongs_to :cart
  
  
end
