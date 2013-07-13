class DeliveryLocation < ActiveRecord::Base
  ############# CONFIGURATION #############
 
  ## SETUP ASSOCIATIONS
  
  belongs_to :market

  has_many :delivery_windows, as: :deliverable, dependent: :destroy
  accepts_nested_attributes_for :delivery_windows, allow_destroy: true, reject_if: proc { |attrs| attrs['weekday'].blank? or attrs['start_hour'].blank? or attrs['end_hour'].blank? or attrs['transport_by'].blank? }
  

  ## ATTRIBUTE PROTECTION
  
  attr_accessible :name, :market_id,
    :street_address_1, :street_address_2, 
    :city, :state, :country, :zip,


  ## ATTRIBUTE VALIDATION

  validates :market_id, :name, :street_address_1,
    :city, :state, :country, :zip,
    presence: true

  #########################################




  ############### CALLBACKS ###############

  #before_validation
  #after_validation
  #before_save
  #before_create
  #after_create
  #after_save
  #after_commit

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
