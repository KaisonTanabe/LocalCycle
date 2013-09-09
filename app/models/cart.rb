class Cart < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :order
  
  has_many :cart_items, :dependent => :destroy
  
  
  def clear_cart
    
  end
  
  
  def total
     total =0.0
		cart_items.includes(:good).each do |item|
	    total = total + (item.price * item.quantity)
	  end
    total
  end
  
  private 
  
  
  
end
