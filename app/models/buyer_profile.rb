class BuyerProfile < ActiveRecord::Base
  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS

  belongs_to :user

  has_attached_file :pic, styles: IMAGE_STYLES, default_url: "/assets/buyer_profile_pics/:style/missing.png"


  has_many :agreements, class_name: "Agreement", foreign_key: "buyer_id", dependent: :destroy

  ## ATTRIBUTE PROTECTION
  
  attr_accessible :name, :latitude, :longitude, :phone,
    :street_address_1, :street_address_2, :city, :state, :country, :zip,
    :description, :website, :twitter, :facebook,
    :certifications, :growing_methods,
    :has_eggs, :has_livestock, :has_dairy, :has_pantry, :user_id,
    :pic, :text_updates



  ## ATTRIBUTE VALIDATION

  validates :name, :phone, :description,
    :street_address_1, :city, :state, :country, :zip,
    presence: true

  validates_attachment :pic,
    :size => { :in => 0..2.megabytes }

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
