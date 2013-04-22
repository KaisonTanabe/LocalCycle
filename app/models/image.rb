class Image < ActiveRecord::Base
  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS

  belongs_to :imageable, polymorphic: true
  has_attached_file :image, styles: IMAGE_STYLES, default_url: DEFAULT_PAPERCLIP_IMAGE

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
