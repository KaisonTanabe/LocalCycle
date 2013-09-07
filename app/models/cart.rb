class Cart < ActiveRecord::Base
  
  belongs_to :user
  has_many :cart_items, :dependent => :destroy
  
  def clear_cart
    
  end
  
  
  private 
  
  def calculate_line_price qty, good, user
    
  end
  
  
end
