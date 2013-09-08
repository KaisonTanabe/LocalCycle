class PricePoint < ActiveRecord::Base
  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS

  belongs_to :good
  belongs_to :selling_unit

  belongs_to :producer, class_name: "User", foreign_key: :producer_id
  ## ATTRIBUTE PROTECTION

  attr_accessible :price, :quantity, :selling_unit_id, :buyers, :producer_id

  ## ATTRIBUTE VALIDATION

  validates :selling_unit_id, :price, :quantity, presence: true

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
