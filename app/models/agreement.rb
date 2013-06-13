class Agreement < ActiveRecord::Base

  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS

  has_many :preferred_user_agreements, dependent: :destroy
  has_many :preferred_users, through: :preferred_user_agreements

  has_many :images, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  has_many :delivery_windows, as: :deliverable, dependent: :destroy
  accepts_nested_attributes_for :delivery_windows, allow_destroy: true, reject_if: proc { |attrs| attrs['weekday'].blank? or attrs['start_hour'].blank? or attrs['start_hour'].blank? }

  has_many :agreement_changes, dependent: :destroy

  belongs_to :product
  belongs_to :buyer, class_name: "User", foreign_key: :buyer_id
  belongs_to :producer, class_name: "User", foreign_key: :producer_id
  belongs_to :creator, class_name: "User", foreign_key: :creator_id

  ## ATTRIBUTE PROTECTION
  
  attr_accessible :product_id, :name, :description, :producer_id, :buyer_id, :creator_id,
    :agreement_type, :start_date, :end_date,
    :selling_unit, :price, :locally_packaged, :frequency, :quantity,
    :transport_by, :transport_instructions,
    :images_attributes, :delivery_windows_attributes, :preferred_user_ids

  ## ATTRIBUTE VALIDATION

  validates :product_id, :name, :agreement_type,
    :creator_id, :selling_unit, :price, presence: true

  validates :locally_packaged, inclusion: {:in => [true, false]}
  validates :agreement_type, inclusion: {:in => AGREEMENT_TYPES.map {|a| a.first}}
  validates :frequency, inclusion: {:in => FREQUENCIES.map {|f| f.first}}

  validates :frequency, presence: true, :if => lambda { self.agreement_type == "indefinite"}
  validates :start_date, presence: true, :if => lambda { self.agreement_type == "onetime"}
  validates :start_date, :end_date, :frequency, presence: true, :if => lambda { self.agreement_type == "seasonal"}

  validate :start_end_dates

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

  scope :by_complete, where("buyer_id > 0 AND producer_id > 0")
  scope :by_not_complete, where("buyer_id = 0 OR producer_id = 0")

  scope :available_supply, where(buyer_id: 0)
  scope :available_demand, where(producer_id: 0)

  scope :by_interacted_with, lambda {|id| includes(:agreement_changes).where("agreement_changes.user_id = ?", id)}
  scope :by_interacted_with_or_mine, lambda {|id| includes(:agreement_changes).where("agreement_changes.user_id = ? OR agreements.creator_id = ?", id, id)}

  scope :by_name, lambda { |n| where('UPPER(agreements.name) LIKE UPPER(?)', '%'+n+'%')}
  scope :by_min_price, lambda {|p| where("price >= ?", p.to_i)}
  scope :by_max_price, lambda {|p| where("price <= ?", p.to_i)}
  scope :by_min_quantity, lambda {|q| where("quantity >= ?", q.to_i)}
  scope :by_max_quantity, lambda {|q| where("quantity <= ?", q.to_i)}
  scope :by_buyer, lambda {|b| where("buyer_id = ?", b)}
  scope :by_producer, lambda {|p| where("producer_id = ?", p)}
  scope :by_creator, lambda {|p| where("creator_id = ?", p)}
  scope :by_product, lambda {|p| where("product_id = ?", p)}
  scope :in_category, lambda { |c| includes(:product).where("products.category_id IN (?)", Category.where(id: c).first.self_and_descendant_ids) }
  scope :available_supply_or_mine, lambda{ |b| where("buyer_id = 0 OR buyer_id = ?", b)}
  scope :available_demand_or_mine, lambda{ |p| where("producer_id = 0 OR producer_id = ?", p)}
  scope :standing_supply, available_supply.where("agreements.start_date <= ? AND agreement_type = 'onetime'", Date.today)
  scope :standing_demand, available_demand.where("agreements.start_date <= ? AND agreement_type = 'onetime'", Date.today)
  scope :standing_mine, lambda{ |cid| available_supply.where('agreements.start_date <= ? AND agreement_type = ? AND creator_id = ?', Date.today, "onetime", cid) }


  scope :near, lambda{ |*args|
    origin = *args.first[:origin]
    origin_lat, origin_lng = origin
    origin_lat, origin_lng = (origin_lat.to_f / 180.0 * Math::PI), (origin_lng.to_f / 180.0 * Math::PI)
    within = *args.first[:within]
    {
      :conditions => %(
        (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(users.lat))*COS(RADIANS(users.lng))+
        COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(users.lat))*SIN(RADIANS(users.lng))+
        SIN(#{origin_lat})*SIN(RADIANS(users.lat)))*3963) <= #{within[0]}
      ),
      :select => %( agreements.*,
        (ACOS(COS(#{origin_lat})*COS(#{origin_lng})*COS(RADIANS(users.lat))*COS(RADIANS(users.lng))+
        COS(#{origin_lat})*SIN(#{origin_lng})*COS(RADIANS(users.lat))*SIN(RADIANS(users.lng))+
        SIN(#{origin_lat})*SIN(RADIANS(users.lat)))*3963) AS distance
      )
    }
  }

  #########################################



  ############ CLASS METHODS ##############

  def self.csv_header 
    "First Name,Last Name,Email,Teams".split(',') 
  end

  def self.build_from_csv(row) 
    # find existing customer from email or create new 
    agreement = Agreement.where(email: row[2]).first_or_initialize
    agreement.attributes = {
      :first_name => row[0],
      :last_name => row[1],
      :email => row[2],
      :teams => Team.names_to_records(row[3].split("||"))
    }
    return agreement
  end 


  ############ PUBLIC METHODS #############

  def quantity
    read_attribute(:quantity).nil? ? "--" : read_attribute(:quantity)
  end

  def to_csv
    [id, name, email, ""]
  end

  def users
    users = []
    users << buyer if buyer
    users << producer if producer
    return users
  end

  def user_names
    users.map {|u| u.name }.join(' + ')
  end

  def has_producer?
    producer_id != 0
  end
  def has_buyer?
    buyer_id != 0
  end
  def is_complete?
    has_buyer? and has_producer?
  end

  def owned_by(u)
    creator_id == u.id
  end

#  def deadline_is_possible?
#    return if [deadline.blank?, begins_at.blank?].any?
#    if deadline > begins_at
#      errors.add(:deadline, 'must be possible')
#    end
#  end

  def duration
    if agreement_type == "onetime"
      "Once"
    elsif agreement_type == "indefinite"
      "Indefinite"
    else
      start_date.strftime("%b %e") + " - " + end_date.strftime("%b %e")
    end
  end

  def status(cid)
    return "success" if (buyer_id > 0 and producer_id > 0)
    return "warning" if (creator_id != cid) and agreement_changes.by_user(cid).by_agreed.any?
    return "info" if (creator_id == cid)
    return "available"
  end

  def bar_status(cid)
    return "complete" if (buyer_id > 0 and producer_id > 0)
    return "terminated" if (creator_id != cid and agreement_changes.by_user(cid).by_terminated.any?)
    return "pending" if agreement_changes.by_user(cid).any?
    return "listed" if creator_id == cid
    return "available"
  end

  def mark_complete(ac)
    self.producer_id = ac.user.id if ac.user.producer?
    self.buyer_id = ac.user.id if ac.user.buyer?
    self.save!
    # send emails
  end

  def is_preferred(u)
    preferred_users.include?(u)
  end

  def bar_margins
    if agreement_type == "indefinite"
      ""
    else
      "margin-left: " + bar_margin_left.to_s + "%; margin-right: " + bar_margin_right.to_s + "%;"
    end
  end

  def start_bar_margins
    "margin-left: 0%; margin-right: " + bar_margin_right.to_s + "%;"
  end

  def end_bar_margins
    "margin-left: " + bar_margin_left.to_s + "%; margin-right: 0%;"
  end

  ############ PRIVATE METHODS ############
  private

  def start_end_dates
    if end_date and start_date and end_date < start_date
      errors.add(:end_date, 'must be after the agreement start date') 
    end
  end

  def bar_margin_left
    (start_date.yday.to_f/365)*100
  end

  def bar_margin_right
    if agreement_type == "onetime"
      100 - ((start_date.yday + 7).to_f/365)*100
    else 
      100 - (end_date.yday.to_f/365)*100
    end
  end

end
