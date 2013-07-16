class Good < ActiveRecord::Base

  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS
  belongs_to :product
  belongs_to :selling_unit
  belongs_to :market
  belongs_to :buyer, class_name: "User", foreign_key: :buyer_id
  belongs_to :producer, class_name: "User", foreign_key: :producer_id
  belongs_to :creator, class_name: "User", foreign_key: :creator_id

  has_many :price_points


  ## ATTRIBUTE PROTECTION  
  
  attr_accessible :product_id, :price_point_ids, :selling_unit_id, :quantity,
    :indefinite, :start_date, :end_date, :creator_id, :market_id


  ## ATTRIBUTE VALIDATION

  validates :product_id, :selling_unit_id, :market_id, :creator_id, presence: true

  validates :indefinite,
    :inclusion => {:in => [true, false]}

  validates :start_date, :end_date, presence: true,
    :if => lambda { self.indefinite == false }
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

  scope :by_name, lambda { |n| where('UPPER(products.name) LIKE UPPER(?)', '%'+n+'%')}
#  scope :by_min_price, lambda {|p| where("price >= ?", p.to_i)}
#  scope :by_max_price, lambda {|p| where("price <= ?", p.to_i)}
  scope :by_min_quantity, lambda {|q| where("quantity >= ?", q.to_i)}
  scope :by_max_quantity, lambda {|q| where("quantity <= ?", q.to_i)}
  scope :by_buyer, lambda {|b| where("buyer_id = ?", b)}
  scope :by_producer, lambda {|p| where("producer_id = ?", p)}
  scope :by_creator, lambda {|p| where("creator_id = ?", p)}
  scope :by_product, lambda {|p| where("product_id = ?", p)}
  scope :in_category, lambda { |c| includes(:product).where("products.category_id IN (?)", Category.where(id: c).first.self_and_descendant_ids) }

  #########################################



  ############ CLASS METHODS ##############

  #def self.
  def self.csv_header 
    "ID,Category,Name,Description,Selling Unit,Catch Weight,Season Start Date,Season End Date".split(',') 
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

  def to_csv
    [id, cat_name, name, description, unit_type, catch_weight, start_date, end_date]
  end

  def quantity
    read_attribute(:quantity).nil? ? "--" : read_attribute(:quantity)
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
    if agreement_type == "onetime"
      "Once"
    elsif agreement_type == "indefinite"
      "Indefinite"
    else
      start_date.strftime("%b %e") + " - " + end_date.strftime("%b %e")
    end
  end

  ############ PRIVATE METHODS ############
  private

end
