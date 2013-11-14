class Market < ActiveRecord::Base
  ############# CONFIGURATION #############
 
  ## SETUP ASSOCIATIONS

  has_and_belongs_to_many :market_managers, class_name: "User", foreign_key: :market_id, :conditions => proc { "role = 'market_manager'" }
  has_and_belongs_to_many :producers, class_name: "User", foreign_key: :market_id, :conditions => proc { "role = 'producer'" }
  has_and_belongs_to_many :buyers, class_name: "User", foreign_key: :market_id, :conditions => proc { "role = 'buyer'" }

  has_and_belongs_to_many :goods

  has_and_belongs_to_many :users
  has_many :sub_orders
  
  has_many :delivery_windows, as: :deliverable, dependent: :destroy
  accepts_nested_attributes_for :delivery_windows, allow_destroy: true, reject_if: proc { |attrs| attrs['weekday'].blank? or attrs['start_hour'].blank? or attrs['start_hour'].blank? }

  belongs_to :network
  
  has_attached_file :pic, styles: IMAGE_STYLES, default_url: "/assets/market_pics/:style/missing.png"

  ## ATTRIBUTE PROTECTION
  
  attr_accessible :name, :brief, :description, :pic, :phone,
    :billing_street_address_1, :billing_street_address_2, 
    :billing_city, :billing_state, :billing_country, :billing_zip,
    :website, :twitter, :facebook, :delivery_windows_attributes, :network_id, :day_of_week, :cycle, :start_time, :end_time, :distribution_fee, :order_min, :start_orders, :end_orders, :markup

  ## ATTRIBUTE VALIDATION

  validates :name,
    :billing_street_address_1,
    :billing_city, :billing_state, :billing_country, :billing_zip,
    presence: true

  #########################################

  CYCLES = %w[daily weekly monthly yearly one-time]


  def next_market
    #need to check cycles in the future
    date = DateTime.current
		
		if end_time && date > date.change({:hour => self.end_time.strftime('%H').to_i, :min => self.end_time.strftime('%M').to_i, :sec => 0 })
	    date = (date + 1.day)change({:hour => 0, :min => 0, :sec => 0 })
	  elsif start_time
        date = date.change({:hour => self.start_time.strftime('%H').to_i, :min => self.start_time.strftime('%M').to_i, :sec => 0 })
      	    
	  end
	  
    
    if start_time
      
  			if self.day_of_week
  				diff = (self.day_of_week - date.wday)
  				puts "#{self.day_of_week} - #{date.wday}"
  			  diff = diff + 7 if diff < 0
  			  puts "DIFF: #{diff}" 
  				date = date + diff.days #.change(:days => diff)
  	    else
  	        #hack until scheme is figured out to calculated market time that isnt weekly
  	        #date = self.start_time
  	        date = nil
  	    end
    else
      date = nil
    end
	    date
  end
  
  
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

  def to_csv
    [name, brief, description, phone, billing_street_address_1, billing_street_address_2, billing_city, billing_state, billing_country, billing_zip]
  end

  def address
    billing_street_address_1 + " " + billing_street_address_2 + " " + billing_city + ", " + billing_state + ", " + billing_zip
  end

  ############ PRIVATE METHODS ############
  private
end
