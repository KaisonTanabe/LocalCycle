class Category < ActiveRecord::Base

  ############# CONFIGURATION #############

  acts_as_tree

  ## SETUP ASSOCIATIONS


  ## ATTRIBUTE PROTECTION

  attr_accessible :description, :name, :parent_id


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
