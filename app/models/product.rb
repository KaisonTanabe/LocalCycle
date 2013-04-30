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

  #scope :by_, where()
  #scope :by_, includes(:model).where()
  scope :by_category, lambda {|c| includes(:category).where("categories.name = ?", c)}
  scope :by_name, lambda { |n| where('UPPER(products.name) LIKE UPPER(?)', '%'+n+'%')}

  #########################################



  ############ CLASS METHODS ##############

  #def self.

  ############ PUBLIC METHODS #############

  def best_pic_url(sym)
    pic? ? pic.url(sym) : category.best_pic_url(sym)
  end

  def best_pic
    pic? ? pic : category.best_pic
  end


  ############ PRIVATE METHODS ############
  private

end
