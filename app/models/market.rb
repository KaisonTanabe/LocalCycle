class Market < ActiveRecord::Base
  ############# CONFIGURATION #############
 
  ## SETUP ASSOCIATIONS

  has_many :goods
  has_many :delivery_locations
  has_many :market_managers, class_name: "User", foreign_key: :market_id
  has_many :producers, class_name: "User", foreign_key: :market_id
  has_many :buyers, class_name: "User", foreign_key: :market_id

  has_attached_file :pic, styles: IMAGE_STYLES, default_url: :set_default_url_on_role

  ## ATTRIBUTE PROTECTION
  
  attr_accessible :name, :brief, :description, :pic, :phone,
    :billing_street_address_1, :billing_street_address_2, 
    :billing_city, :billing_state, :billing_country, :billing_zip,
    :website, :twitter, :facebook

  ## ATTRIBUTE VALIDATION

  validates :name, :brief, :phone,
    :billing_street_address_1,
    :billing_city, :billing_state, :billing_country, :billing_zip,
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
