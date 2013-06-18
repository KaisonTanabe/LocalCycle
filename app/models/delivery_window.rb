class DeliveryWindow < ActiveRecord::Base
  ############# CONFIGURATION #############
 
  ## SETUP ASSOCIATIONS

  belongs_to :deliverable, polymorphic: true

  ## ATTRIBUTE PROTECTION
  
  attr_accessible :weekday, :start_hour, :end_hour, :deliverable_id, :deliverable_type, :transport_by

  ## ATTRIBUTE VALIDATION

  validates :weekday, :start_hour, :end_hour, :transport_by, presence: true

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

  def display
    WEEKDAYS[weekday] + " from " + NORMAL_HOURS[start_hour] + " to " + NORMAL_HOURS[end_hour]
  end

  ############ PRIVATE METHODS ############
  private
end
