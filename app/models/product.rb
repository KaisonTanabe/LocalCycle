class Product < ActiveRecord::Base

  ############# CONFIGURATION #############

  ## SETUP ASSOCIATIONS

  ## ATTRIBUTE PROTECTION
  
  belongs_to :category
  has_attached_file :pic, styles: IMAGE_STYLES, default_url: DEFAULT_PAPERCLIP_IMAGE
  
  attr_accessible :description, :name, :unit_type, :catch_weight, :category_id, :pic

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

  scope :by_category_name, lambda {|c| includes(:category).where("categories.name = ?", c)}
  scope :by_name, lambda { |n| where('UPPER(products.name) LIKE UPPER(?)', '%'+n+'%')}
  scope :in_category, lambda { |c| includes(:category).where(category_id: Category.where(id: c).first.self_and_descendant_ids) }

  #########################################



  ############ CLASS METHODS ##############

  #def self.
  def self.csv_header 
    "ID,Category,Name,Description,Selling Unit,Catch Weight,Season Start Date,Season End Date".split(',') 
  end


  ############ PUBLIC METHODS #############

  def to_csv
    [id, cat_name, name, description, unit_type, catch_weight, start_date, end_date]
  end

  def cat_name
    Category.where(id: category_id).first.name
  end

  def best_pic_url(sym)
    pic? ? pic.url(sym) : category.best_pic_url(sym)
  end

  def best_pic
    pic? ? pic : category.best_pic
  end


  ############ PRIVATE METHODS ############
  private

end
