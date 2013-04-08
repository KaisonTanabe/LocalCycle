class Product < ActiveRecord::Base

  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS

  ## ATTRIBUTE PROTECTION
  
  attr_accessible :description, :name, :unit_type, :catch_weight, :category_id

  ## ATTRIBUTE VALIDATION

  validates :name, :category_id, presence: true

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


  ############ PUBLIC METHODS #############


  ############ PRIVATE METHODS ############
  private

end
