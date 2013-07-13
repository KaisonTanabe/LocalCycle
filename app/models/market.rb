class Market < ActiveRecord::Base
  ############# CONFIGURATION #############
 
  ## SETUP ASSOCIATIONS

  has_many :goods
  has_many :delivery_locations
  has_many :market_managers, class_name: "User", foreign_key: :market_id
  has_many :producers, class_name: "User", foreign_key: :market_id
  has_many :buyers, class_name: "User", foreign_key: :market_id

  ## ATTRIBUTE PROTECTION
  
  attr_accessible :name, :brief, :description,
    :street_address_1, :street_address_2, 
    :city, :state, :country, :zip,
    :billing_street_address_1, :billing_street_address_2, 
    :billing_city, :billing_state, :billing_country, :billing_zip,

  ## ATTRIBUTE VALIDATION

  #validates

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
