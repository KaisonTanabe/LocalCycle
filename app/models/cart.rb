class Cart < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :order
  
  has_many :cart_items, :dependent => :destroy
  
  attr_accessible :cart_items_attributes
  
  
  accepts_nested_attributes_for :cart_items
  
  def clear_cart
    
  end
  
  
  def total
     total =0.0
		cart_items.includes(:good).each do |item|
	    total = total + (item.price * item.quantity)
	  end
    total
  end
  
  def dist_fees
    fee =0
    cart_items.collect{|c| c.market}.uniq.each do |m|
      fee = fee + m.distribution_fee
    end
    fee
    
  end
  
  private 
  
  
  
end
