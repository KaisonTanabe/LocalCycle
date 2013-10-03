class PricePoint < ActiveRecord::Base
  ############# CONFIGURATION #############
  
  ## SETUP ASSOCIATIONS
  after_create :notify_buyers
  
  belongs_to :good
  belongs_to :selling_unit

  belongs_to :producer, class_name: "User", foreign_key: :producer_id
  ## ATTRIBUTE PROTECTION

  attr_accessible :price, :quantity, :selling_unit_id, :buyers, :producer_id

  ## ATTRIBUTE VALIDATION

  validates :selling_unit_id, :price, :quantity, presence: true

  #########################################

  def has_market? market
    hash = JSON.parse buyers
    hash.each do |networks|
      networks.each do |m|
        puts "market #{m}"
      end
    end
    
  end


  ############### CALLBACKS ###############

  #before_validation
  #after_validation
  #before_save
  #before_create
  #after_create
  #after_save
  #after_commit
  
  def notify_buyers
    puts "NOTIFYING BUYERS!"
    
    hash = JSON.parse self.buyers
    hash.each do |market|
        mark = Market.find(market[0].to_i)
        puts market.to_yaml
        market[1].each do |buyer|
          
            if(buyer.kind_of?(Array))
              buyer.each do |b|
                u_buyer = User.find(b.to_i)
                BuyerMailer.new_pricepoint(u_buyer, self, mark).deliver

              end
            
            else
                u_buyer = User.find(buyer.to_i)
                BuyerMailer.new_pricepoint(u_buyer, self, mark).deliver

              
            end
            
            
            
        end
    end
    

	  

 	  
  end
  

  #########################################



  ################ SCOPES #################

  #scope :by_, where()
  #scope :by_, includes(:model).where()
  #scope :by_, lambda {|s| where()}

  #########################################



  ############ CLASS METHODS ##############

  #def self.

  ############ PUBLIC METHODS #############


  ############ PRIVATE METHODS ############
  private
end
