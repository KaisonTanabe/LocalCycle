class Product < ActiveRecord::Base

  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS

  ## ATTRIBUTE PROTECTION
  
  has_attached_file :pic, styles: {xlarge: "1500x1000>", large: "600x400>", medium: "240x160>", thumb: "60x40>"}, default_url: "/images/:style/missing.png"
  
  attr_accessible :description, :name, :unit_type, :catch_weight, :category_id, :pic

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
