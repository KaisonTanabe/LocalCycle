class Good < ActiveRecord::Base

  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS
  belongs_to :product
  belongs_to :selling_unit
  belongs_to :buyer, class_name: "User", foreign_key: :buyer_id
  belongs_to :producer, class_name: "User", foreign_key: :producer_id
  belongs_to :creator, class_name: "User", foreign_key: :creator_id
  
  belongs_to :wishlist
  has_and_belongs_to_many :certifications
  has_many :price_points, dependent: :destroy
  accepts_nested_attributes_for :price_points, allow_destroy: true, reject_if: proc { |attrs| attrs['price'].blank? or attrs['quantity'].blank? or attrs['selling_unit_id'].blank? }

  has_and_belongs_to_many :markets

  has_attached_file :pic, styles: IMAGE_STYLES, default_url: DEFAULT_PAPERCLIP_IMAGE

  ## ATTRIBUTE PROTECTION  
  
  attr_accessible :product_id, :quantity, :start_date, :end_date, :creator_id, :market_id, :price_points_attributes, :available, :selling_unit_id, :certification_ids, :wishlist_id, :producer_id, :cycle, :description, :order_cutoff, :pic


  ## ATTRIBUTE VALIDATION

  validates :product_id, :creator_id, presence: true

  validates :available,
    :inclusion => {:in => [true, false]}

  validate :must_have_price_point

  #validates :end_date, presence: true
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

  scope :in_month, lambda{|m| {:conditions => ['end_date >= ? AND start_date <= ?', Date.new(Date.today.year, m.to_i, 1), Date.new(Date.today.year, m.to_i, 1).end_of_month]}}

  
  scope :available_supply, where(buyer_id: 0)
  scope :available_demand, where(producer_id: 0)

  scope :by_name, lambda { |n| includes(:product).where('UPPER(products.name) LIKE UPPER(?)', '%'+n+'%')}
#  scope :by_min_price, lambda {|p| where("price >= ?", p.to_i)}
#  scope :by_max_price, lambda {|p| where("price <= ?", p.to_i)}
  scope :by_min_quantity, lambda {|q| where("quantity >= ?", q.to_i)}
  scope :by_max_quantity, lambda {|q| where("quantity <= ?", q.to_i)}
  scope :by_buyer, lambda {|b| where("buyer_id = ?", b)}
  scope :by_producer, lambda {|p| where("producer_id = ?", p)}
  scope :by_creator, lambda {|p| where("creator_id = ?", p)}
  scope :by_product, lambda {|p| where("product_id = ?", p)}
  scope :by_market, lambda {|n| joins(:markets).("market.id = ?", n)}
  scope :in_category, lambda { |c| includes(:product).where("products.category_id IN (?)", Category.where(id: c).first.self_and_descendant_ids) }

  #########################################



  ############ CLASS METHODS ##############


  
  def update_markets
    self.markets.each do |m|
      self.markets.delete(m)
    end
    price_points.each do |pp|
      puts "#{pp.buyers.to_yaml}"
      hash = JSON.parse pp.buyers
      hash.each do |market|
          mark = Market.find(market[0].to_i)
          self.markets << mark if !self.markets.include?(mark) 
      end
      
    end
    
  end
  
  
  #def self.
  def self.csv_header 
    "ID,Name,Description,Season Start Date,Season End Date".split(',') 
  end

  def self.build_from_csv(row)
    good = Good.where(id: row[0]).first_or_initialize
    start_date = row[6].split("-")
    end_date = row[7].split("-")
    good.attributes = {
      :unit_type => row[4],
      :catch_weight => row[5],
      :start_date => Date.new(start_date[2].to_i, start_date[0].to_i, start_date[1].to_i),
      :end_date => Date.new(end_date[2].to_i, end_date[0].to_i, end_date[1].to_i),
    }
    return good
  end


  ############ PUBLIC METHODS #############

  def must_have_price_point
    if price_points.empty? or price_points.all? {|pp| pp.marked_for_destruction? }
      errors.add(:base, 'Must have at least one price point')
    end
  end

  def to_csv
    [id, name, description, start_date, end_date]
  end

  def quantity
    read_attribute(:quantity).nil? ? "--" : read_attribute(:quantity)
  end

  def name
    product.name
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

  def created_by?(u)
    creator_id == u.id
  end
  def has_producer?
    producer_id != 0
  end
  def has_buyer?
    buyer_id != 0
  end

  def duration
    "Expires " + end_date.strftime("%b %e") if end_date
  end

  def has_certification(c_id)
    ids = certifications.collect{|cert| cert.id}
    return ids.include(c_id)
  end
  
  def best_pic_url(sym)
    (pic?) ? pic.url(sym) : product.best_pic_url(sym)
  end

  ############ PRIVATE METHODS ############
  private

end
