class AgreementChange < ActiveRecord::Base
  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS

  belongs_to :agreement
  belongs_to :producer, class_name: "ProducerProfile", foreign_key: :producer_id
  # OR
  belongs_to :buyer, class_name: "BuyerProfile", foreign_key: :buyer_id

  has_many :delivery_windows, as: :deliverable, dependent: :destroy
  accepts_nested_attributes_for :delivery_windows, allow_destroy: true, reject_if: proc { |attrs| attrs['weekday'].blank? or attrs['start_hour'].blank? or attrs['start_hour'].blank? }

  ## ATTRIBUTE PROTECTION
  
  attr_accessible :price, :quantity, :frequency,
    :agreement_id, :producer_id, :buyer_id, :reason, 
    :transport_by, :transport_instructions, :agree

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

  default_scope order('created_at DESC')

  scope :by_agreed, where(agree: true)
  scope :by_producer, lambda {|p| where(producer_id: p)}
  scope :by_buyer, lambda {|b| where(buyer_id: b)}
  scope :by_producer_or_buyer, lambda {|id| where("producer_id = ? OR buyer_id = ?", id, id)}

  #########################################



  ############ CLASS METHODS ##############

  #def self.

  ############ PUBLIC METHODS #############


  ############ PRIVATE METHODS ############
  private

end
