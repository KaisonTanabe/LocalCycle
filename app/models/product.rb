class Product < ActiveRecord::Base

  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS
=begin
  has_and_belongs_to_many :users
=end

  belongs_to :category
  has_attached_file :pic, styles: IMAGE_STYLES, default_url: DEFAULT_PAPERCLIP_IMAGE

  has_many :agreements

  has_many :products_selling_units, dependent: :destroy
  has_many :selling_units, through: :products_selling_units


  ## ATTRIBUTE PROTECTION  
  
  attr_accessible :description, :name, :selling_unit_ids, :greenhouse_grown,
    :catch_weight, :category_id, :pic, :start_date, :end_date


  ## ATTRIBUTE VALIDATION

  validates :name, :category_id, presence: true

  validates_attachment :pic,
    :size => { :in => 0..2.megabytes }

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

  scope :available_demand_only, includes(:agreements).where("agreements.buyer_id = 0")
  scope :available_supply_only, includes(:agreements).where("agreements.producer_id = 0")
  scope :available_demand_and_mine_only, lambda {|b| includes(:agreements).where("agreements.buyer_id = 0 OR agreements.buyer_id = ?", b)}
  scope :available_supply_and_mine_only, lambda {|p| includes(:agreements).where("agreements.producer_id = 0 OR agreements.producer_id = ?", p)}

  scope :in_month, lambda{|m| {:conditions => ['end_date >= ? AND start_date <= ?', Date.new(Date.today.year, m.to_i, 1), Date.new(Date.today.year, m.to_i, 1).end_of_month]}}

  scope :by_category_name, lambda {|c| includes(:category).where("categories.name = ?", c)}
  scope :by_name, lambda { |n| where('UPPER(products.name) LIKE UPPER(?)', '%'+n+'%')}
  scope :in_category, lambda { |c| includes(:category).where(category_id: Category.where(id: c).first.self_and_descendant_ids) }

  scope :by_producer, lambda { |p| includes(:agreements).where("agreements.producer_id = ?", p) }
  scope :by_buyer, lambda { |p| includes(:agreements).where("agreements.buyer_id = ?", p) }

  scope :by_standing_supply, includes(:agreements).where("agreements.start_date <= ? AND agreements.agreement_type = ? AND agreements.buyer_id IS NULL", Date.today, "onetime")
  scope :by_standing_demand, includes(:agreements).where("agreements.start_date <= ? AND agreements.agreement_type = ? AND agreements.producer_id IS NULL", Date.today, "onetime")

  #########################################



  ############ CLASS METHODS ##############

  #def self.
  def self.csv_header 
    "ID,Category,Name,Description,Catch Weight,Seasonal Start Date,Seasonal End Date".split(',') 
  end

  def self.build_from_csv(row)
    product = Product.where(id: row[0]).first_or_initialize
    start_date = row[6].split("-")
    end_date = row[7].split("-")
    product.attributes = {
      :catch_weight => row[5],
      :start_date => Date.new(start_date[2].to_i, start_date[0].to_i, start_date[1].to_i),
      :end_date => Date.new(end_date[2].to_i, end_date[0].to_i, end_date[1].to_i),
    }
    return product
  end


  ############ PUBLIC METHODS #############

  def to_csv
    [id, category.name, name, description, catch_weight, start_date, end_date]
  end

  def availability
    start_date.strftime("%b %-d") + " - " + end_date.strftime("%b %-d")
  end

  def best_pic_url(sym)
    pic? ? pic.url(sym) : category.best_pic_url(sym)
  end

  def best_pic
    pic? ? pic : category.best_pic
  end

  def possible_units
    selling_units.map {|su| su.short_name }.join(" &middot; ")
  end

=begin
  def bar_margins
    "margin-left: " + bar_margin_left.to_s + "%; margin-right: " + bar_margin_right.to_s + "%;"
  end

  def start_bar_margins
    "margin-left: 0%; margin-right: " + bar_margin_right.to_s + "%;"
  end

  def end_bar_margins
    "margin-left: " + bar_margin_left.to_s + "%; margin-right: 0%;"
  end

  ############ PRIVATE METHODS ############
  private

  def bar_margin_left
    (start_date.yday.to_f/365)*100
  end

  def bar_margin_right
    100 - (end_date.yday.to_f/365)*100
  end
=end

end
