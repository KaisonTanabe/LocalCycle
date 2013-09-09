class Address < ActiveRecord::Base
  attr_accessible :address_1, :address_2, :city, :state, :zip
  
  has_one :order
  
  validates :address_1, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip, :presence => true
  
end
