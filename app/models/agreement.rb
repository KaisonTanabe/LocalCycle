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

  validates :start_date, :end_date, presence: true, :if => lambda { self.agreement_type == "seasonal"}
  validates :start_date, presence: true, :if => lambda { self.agreement_type == "onetime"}

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
  scope :by_buyer, lambda {|b| where("buyer_id = ?", b)}
  scope :by_producer, lambda {|b| where("producer_id = ?", b)}
  scope :by_product, lambda {|p| where("product_id = ?", p)}
  scope :available_supply, where(buyer_id: nil)
  scope :available_demand, where(producer_id: nil)

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

  def to_csv
    [id, name, email, teams.map{|t| t.full_team_name}.join("||")]
  end

  def deadline_is_possible?
    return if [deadline.blank?, begins_at.blank?].any?
    if deadline > begins_at
      errors.add(:deadline, 'must be possible')
    end
  end

  def bar_margins
    if agreement_type == "indefinite"
      ""
    else
      "margin-left: " + bar_margin_left.to_s + "%; margin-right: " + bar_margin_right.to_s + "%;"
    end
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

  def bar_status(cid)
    puts producer_id
    return "complete" if (!buyer_id.nil? and !producer_id.nil?)
    return "pending" if (buyer_id == cid and producer_id.nil?) or (producer_id == cid and buyer_id.nil?)
  end

  ############ PRIVATE METHODS ############
  private

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
