class BuyerProfile < ActiveRecord::Base
  ############# CONFIGURATION #############
  require 'geokit'
  include GeoKit::Geocoders
  
  ## SETUP ASSOCIATIONS

  belongs_to :user

  has_attached_file :pic, styles: IMAGE_STYLES, default_url: "/assets/buyer_profile_pics/:style/missing.png"

  has_many :delivery_windows, as: :deliverable, dependent: :destroy
  accepts_nested_attributes_for :delivery_windows, allow_destroy: true, reject_if: proc { |attrs| attrs['weekday'].blank? or attrs['start_hour'].blank? or attrs['start_hour'].blank? }

  has_many :agreements, class_name: "Agreement", foreign_key: "buyer_id", dependent: :destroy

  ## ATTRIBUTE PROTECTION
  
  attr_accessible :name, :phone, :user_id,
    :street_address_1, :street_address_2, :city, :state, :country, :zip,
    :description, :website, :twitter, :facebook,
    :transport_by, :delivery_windows_attributes,
    :pic, :text_updates



  ## ATTRIBUTE VALIDATION

  validates :name, :phone, :description,
    :street_address_1, :city, :state, :zip,
    presence: true

  validates_attachment :pic,
    :size => { :in => 0..2.megabytes }

  #########################################




  ############### CALLBACKS ###############

  #before_validation
  #after_validation
  before_save :set_lat_long
  #before_create
  #after_create
  #after_save
  #after_commit

  #########################################



  ################ SCOPES #################

  #scope :by_, where()
  #scope :by_, includes(:model).where()
  #scope :by_, lambda {|s| where()}

  scope :near, lambda{ |*args|
    origin = *args.first[:origin]
    origin_lat, origin_lng = origin
    origin_lat, origin_lng = (origin_lat.to_f / 180.0 * Math::PI), (origin_lng.to_f / 180.0 * Math::PI)
    within = *args.first[:within]
    {
      :conditions => %(
        (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(buyer_profiles.lat))*COS(RADIANS(buyer_profiles.lng))+
        COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(buyer_profiles.lat))*SIN(RADIANS(buyer_profiles.lng))+
        SIN(#{origin_lat})*SIN(RADIANS(buyer_profiles.lat)))*3963) <= #{within[0]}
      ),
      :select => %( buyer_profiles.*,
        (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(buyer_profiles.lat))*COS(RADIANS(buyer_profiles.lng))+
        COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(buyer_profiles.lat))*SIN(RADIANS(buyer_profiles.lng))+
        SIN(#{origin_lat})*SIN(RADIANS(buyer_profiles.lat)))*3963) AS distance
      )
    }
  }
  #########################################



  ############ CLASS METHODS ##############

  #def self.

  ############ PUBLIC METHODS #############


  ############ PRIVATE METHODS ############
  private

  def set_lat_long
    res = MultiGeocoder.geocode(self.street_address_1 + (self.street_address_2 ? " " + self.street_address_2 : "") + ", " + self.city + ", " + self.state + " " + self.zip)
    self.latlong = res.ll
    self.lat = res.lat
    self.lng = res.lng
  end
end
