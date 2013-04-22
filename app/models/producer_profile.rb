class ProducerProfile < ActiveRecord::Base
  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS
  belongs_to :user
  has_and_belongs_to_many :certifications

  has_attached_file :pic, styles: IMAGE_STYLES, default_url: DEFAULT_PAPERCLIP_IMAGE

  ## ATTRIBUTE PROTECTION
  attr_accessible :name, :latitude, :longitude, :phone, :growing_methods,
    :street_address_1, :street_address_2, :city, :state, :country, :zip,
    :description, :website, :twitter, :facebook, :user_id, :certification_ids,
    :has_eggs, :has_dairy, :has_livestock, :has_pantry, :pic, :text_updates, :custom_growing_methods

  ## ATTRIBUTE VALIDATION
  validates :name, :phone,
    :street_address_1, :city, :state, :country, :zip,
    :description, :user_id, :growing_methods,
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


  ############ PUBLIC METHODS #############


  ############ PRIVATE METHODS ############
  private


end
