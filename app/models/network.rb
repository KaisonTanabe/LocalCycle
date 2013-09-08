class Network < ActiveRecord::Base
  attr_accessible :name
  has_many :user_networks
  has_many :markets
  
  has_many :users, :through => :user_networks
  
end
