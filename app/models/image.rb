class Image < ActiveRecord::Base
  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS

  belongs_to :imageable, polymorphic: true
  has_attached_file :image, styles: {xlarge: "1500x1000>", large: "600x400>", medium: "240x160>", thumb: "60x40>"}

  ## ATTRIBUTE PROTECTION
  
  attr_accessible :image, :imageable_id, :imageable_type

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
