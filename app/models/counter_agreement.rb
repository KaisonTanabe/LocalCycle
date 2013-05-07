class CounterAgreement < ActiveRecord::Base
  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS

  belongs_to :agreement
  belongs_to :user

  ## ATTRIBUTE PROTECTION
  
  attr_accessible :price, :quantity, :reasons, :agreement_id, :user_id

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
