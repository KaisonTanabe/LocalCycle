class Agreement < ActiveRecord::Base

  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS
  
  belongs_to :product
  belongs_to :buyer, class_name: "User", foreign_key: :buyer_id
  belongs_to :producer, class_name: "User", foreign_key: :producer_id

  ## ATTRIBUTE PROTECTION
  
  attr_accessible :product_id, :name, :description, :producer_id, :buyer_id,
    :quantity, :agreement_type, :start_date, :end_date,
    :selling_unit, :price, :locally_packaged, :can_deliver,
    :can_pickup, :delivery_options, :pickup_options

  ## ATTRIBUTE VALIDATION

  validates :product_id, :name, :quantity, :agreement_type,
    :selling_unit, :price, presence: true

  validates :locally_packaged, :can_deliver,
  :can_pickup, inclusion: {:in => [true, false]}

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
