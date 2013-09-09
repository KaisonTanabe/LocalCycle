class Transaction < ActiveRecord::Base
  attr_accessible :card_type, :name, :exp_month, :exp_year, :cvv, :amount, :authorization_code, :credit_card
  attr_accessor :credit_card
  
  has_one :order
  
  validates :credit_card, :presence => true 
  validates :exp_year, :presence => true 
  validates :exp_month, :presence => true 

  def get_exp
    exp = "#{exp_month}#{exp_year.to_s[-2,2]}"
  end
  
end
