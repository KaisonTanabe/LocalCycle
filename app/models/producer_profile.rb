class ProducerProfile < ActiveRecord::Base
  ############# CONFIGURATION #############
  require 'geokit'
  include GeoKit::Geocoders

  ## SETUP ASSOCIATIONS
  belongs_to :user
  has_and_belongs_to_many :certifications  

  has_many :delivery_windows, as: :deliverable, dependent: :destroy
  accepts_nested_attributes_for :delivery_windows, allow_destroy: true, reject_if: proc { |attrs| attrs['weekday'].blank? or attrs['start_hour'].blank? or attrs['start_hour'].blank? }

  has_attached_file :pic, styles: IMAGE_STYLES, default_url: "/assets/producer_profile_pics/:style/missing.png"

  has_many :agreements, class_name: "Agreement", foreign_key: "producer_id", dependent: :destroy


  ## ATTRIBUTE PROTECTION
  attr_accessible :name, :phone, :growing_methods,
    :street_address_1, :street_address_2, :city, :state, :country, :zip,
    :description, :website, :twitter, :facebook, 
    :user_id, :certification_ids, :text_updates, 
    :has_eggs, :has_dairy, :has_livestock, :has_pantry, :pic, :custom_growing_methods,
    :transport_by, :delivery_windows_attributes, :size

  ## ATTRIBUTE VALIDATION
  validates :name, :phone, :size,
    :street_address_1, :city, :state, :country, :zip,
    :description, :user_id, :growing_methods,
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

  scope :by_size, lambda {|s| where("size = ?", s)}
  scope :by_growing_methods, lambda {|g| where("growing_methods = ?", g)}
  scope :order_best_available, order("size ASC")

  scope :near, lambda{ |*args|
    origin = *args.first[:origin]
    origin_lat, origin_lng = origin
    origin_lat, origin_lng = (origin_lat.to_f / 180.0 * Math::PI), (origin_lng.to_f / 180.0 * Math::PI)
    within = *args.first[:within]
    {
      :conditions => %(
        (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(producer_profiles.lat))*COS(RADIANS(producer_profiles.lng))+
        COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(producer_profiles.lat))*SIN(RADIANS(producer_profiles.lng))+
        SIN(#{origin_lat})*SIN(RADIANS(producer_profiles.lat)))*3963) <= #{within[0]}
      ),
      :select => %( producer_profiles.*,
        (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(producer_profiles.lat))*COS(RADIANS(producer_profiles.lng))+
        COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(producer_profiles.lat))*SIN(RADIANS(producer_profiles.lng))+
        SIN(#{origin_lat})*SIN(RADIANS(producer_profiles.lat)))*3963) AS distance
      )
    }
  }
  
  #########################################



  ############ CLASS METHODS ##############

  #def self.

  ############ PUBLIC METHODS #############

  def display_size
    return "S" if size == 0
    return "M" if size == 1
    return "L" if size == 2
  end

  def distance_from(otherlatlong)
    a = Geokit::LatLng.new(latlong)
    b = Geokit::LatLng.new(otherlatlong)
    return '%.2f' % a.distance_to(b)
  end

  ############ PRIVATE METHODS ############
  private

  def set_lat_long
    res = MultiGeocoder.geocode(self.street_address_1 + (self.street_address_2 ? " " + self.street_address_2 : "") + ", " + self.city + ", " + self.state + " " + self.zip)
    self.latlong = res.ll
    self.lat = res.lat
    self.lng = res.lng
  end
end
