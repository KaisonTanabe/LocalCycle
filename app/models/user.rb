class User < ActiveRecord::Base


  ############# CONFIGURATION #############

  include Extensions::Authenticatable

  ## SETUP ASSOCIATIONS
  has_many :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true

  has_one :buyer_profile
  accepts_nested_attributes_for :buyer_profile, allow_destroy: true
  has_one :producer_profile
  accepts_nested_attributes_for :producer_profile, allow_destroy: true


  ## ATTRIBUTE PROTECTION
  attr_accessible :first_name, :last_name, :email, :notes,
    :attachments_attributes, :role, :producer_profile_attributes


  ## ATTRIBUTE VALIDATION
  validates :first_name, :last_name, :email,   presence: true
  validates :email,                            uniqueness: true
  validates :role,                inclusion: {:in => ROLES.map{ |r| r.first}}


  #########################################




  ################ CALLBACKS ################

#  before_create {|u| u.build_form()}
  before_save :strip_whitespace
  
  #########################################


  ################ SCOPES #################

  scope :active_only, where(active: true)
  scope :by_seen, lambda { |s| includes(:form).where("forms.seen = ?", s)}
  scope :reviewers, where("role = ? OR role = ?", "cm", "admin")
  scope :denied_form, lambda { |f| includes(:form_reviews).where("form_reviews.form_id = ? AND form_reviews.review != ?", f, "approve") }

  #########################################


  ############ CLASS METHODS ##############

  def self.csv_header
    "First Name,Last Name,Email".split(',')
  end

  def self.build_from_csv(row) 
    # find existing customer from email or create new 
    user = find_or_initialize_by_email(row[2]) 
    user.attributes = {
      :first_name => row[0],
      :last_name => row[1],
      :email => row[2]
    }
    return user
  end 


  ############ PUBLIC METHODS #############




  ############ PUBLIC METHODS #############

  def admin?
    role == "admin"
  end
  def buyer?
    role == "buyer"
  end
  def foodhub?
    role == "foodhub"
  end
  def producer?
    role == "producer"
  end

  def has_profile?
    (buyer? and buyer_profile) or (producer? and producer_profile)
  end

  def role_label
    ROLES.key(role)
  end

  def full_name
    first_name.capitalize + " " + last_name.capitalize
  end
  
  def formal_name
    last_name.capitalize + ", " + first_name.capitalize
  end

  def to_csv
    [first_name, last_name, email]
  end

  # Returns the status of the student
  #  - Green if all systems go
  #  - Yellow if physical expiring soon
  #  - Red if requiring form signatures/information
  #  - Gray if inactive
  def user_status
    return "alert-gray" if !active
    return "error" if !form.complete
    return "success"
  end


  ############ PRIVATE METHODS ############
  private
  
  def strip_whitespace
    self.first_name = self.first_name.strip
    self.last_name = self.last_name.strip
    self.email = self.email.strip
  end

end
