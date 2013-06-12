class Category < ActiveRecord::Base

  ############# CONFIGURATION #############

  acts_as_tree
  has_many :products

  ## SETUP ASSOCIATIONS


  ## ATTRIBUTE PROTECTION

  has_attached_file :pic, styles: IMAGE_STYLES, default_url: DEFAULT_PAPERCLIP_IMAGE

  attr_accessible :description, :name, :parent_id, :fakeid, :pic


  ## ATTRIBUTE VALIDATION

  #validates
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
  #scope :by_, lambda {|s| where()}

  #########################################



  ############ CLASS METHODS ##############

  def option_children
    children.collect{|cc| [cc.name, cc.id]}
  end

  def option_products
    products.collect{|p| [p.name, p.id]}
  end


  # Initialize tree creation
  def self.createTreeFromJSON(tree)
    top_level = ["","Meat","Dairy & Soy","Eggs","Fruit","Vegetables","Pantry","Baked Goods","Seafood"]
    puts "Creating Categories and Products"
    tree.each do |k,v|
      if k.to_i <= 8
        cat = Category.create(name: top_level[k.to_i], fakeid: k.to_i)
        createChildren(cat,v)
      else 
        cat = Category.where(fakeid: k.to_i).first
        puts "Category parent not found for: " + v.to_s if cat.nil?
        createProducts(cat,v) if !cat.nil?
      end
    end
  end

  def self.createChildren(parent, children)
    children.each do |child|
      parent.children << Category.create(name: child["name"].titleize, fakeid: child["fakeid"])
    end
  end

  def self.createProducts(parent, products)
    products.each do |product|
      Product.create(name: product["name"].titleize, category_id: parent.id)
    end
  end

  # Initialize tree creation
  def self.createTree(n)
    n.each do |k,v|
      c = Category.create(name: k)
      v.each do |nn|
        c.children << createSubTree(nn)
      end
    end
  end

  # recursive helper method
  def self.createSubTree(n)
    if n.kind_of?(String)
      return Category.create(name: n)
    else # Hash
      c = Category.create(name: n.first)
      n.second.each do |nn|
        c.children << createSubTree(nn)
      end
      return c
    end
  end

  ############ PUBLIC METHODS #############

  def best_pic_url(sym)
    (pic? or root?) ? pic.url(sym) : parent.best_pic_url(sym)
  end

  def best_pic
    (pic? or root?) ? pic : parent.best_pic
  end  

  def readonly?
    false
  end

  ############ PRIVATE METHODS ############
  private


end
