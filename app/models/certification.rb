class Certification < ActiveRecord::Base
  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS
  has_and_belongs_to_many :users

  ## ATTRIBUTE PROTECTION
  attr_accessible :cert_type, :name, :audited

  ## ATTRIBUTE VALIDATION
  validates :name, :cert_type,
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

  scope :by_type, lambda {|s| where(cert_type: s)}
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
