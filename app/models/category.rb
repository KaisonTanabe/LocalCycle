class Category < ActiveRecord::Base

  ############# CONFIGURATION #############

  acts_as_tree

  ## SETUP ASSOCIATIONS


  ## ATTRIBUTE PROTECTION

  attr_accessible :description, :name, :parent_id, :fakeid


  ## ATTRIBUTE VALIDATION

  #validates


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

  # Initialize tree creation
  def self.createTreeFromJSON(tree)
    top_level = ["","Meat","Dairy & Soy","Eggs","Fruit","Vegetables","Pantry","Baked Goods","Sea Food"]
    tree.each do |k,v|
      puts "Creating Categories and Products"
      if k.to_i <= 8
        cat = Category.create(name: top_level[k.to_i], fakeid: k.to_i)
        createChildren(cat,v)
      else 
        cat = Category.where(fakeid: k.to_i).first
        puts "Category parent not found for: " + v if cat.nil?
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


  ############ PUBLIC METHODS #############


  ############ PRIVATE METHODS ############
  private


end
