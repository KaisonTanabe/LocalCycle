class Agreement < ActiveRecord::Base

  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS

  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  
  belongs_to :product
  belongs_to :buyer, class_name: "User", foreign_key: :buyer_id
  belongs_to :producer, class_name: "User", foreign_key: :producer_id

  ## ATTRIBUTE PROTECTION
  
  attr_accessible :product_id, :name, :description, :producer_id, :buyer_id,
    :quantity, :agreement_type, :start_date, :end_date,
    :selling_unit, :price, :locally_packaged, :can_deliver,
    :can_pickup, :delivery_options, :pickup_options, :frequency,
    :images_attributes

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

  def deadline_is_possible?
    return if [deadline.blank?, begins_at.blank?].any?
    if deadline > begins_at
      errors.add(:deadline, 'must be possible')
    end
  end


  ############ PRIVATE METHODS ############
  private


end
