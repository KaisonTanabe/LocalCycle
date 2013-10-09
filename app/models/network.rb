class Network < ActiveRecord::Base
  after_create :associate_with_superadmin
  attr_accessible :name
  has_many :user_networks
  has_many :markets
  
  has_many :users, :through => :user_networks
  
  def associate_with_superadmin
    User.where(:role => 'admin').each do |u|
      u.networks << self
      s = u.user_networks.where(:network_id => self.id).first
      s.approved = true
      s.save
    end
    
  end
  
end
