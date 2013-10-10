class Network < ActiveRecord::Base
  after_create :associate_with_superadmin
  attr_accessible :name
  has_many :user_networks
  has_many :markets
  
  has_many :users, :through => :user_networks
  
  def associate_with_superadmin
    User.where(:role => 'admin').each do |u|
      UserNetworks.create(:network_id => self.id, :user_id => u.id, :approved => true)
    end
    
  end
  
end
