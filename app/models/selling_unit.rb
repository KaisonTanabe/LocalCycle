class SellingUnit < ActiveRecord::Base
  attr_accessible :name, :short_name

  has_many :products_selling_units, dependent: :destroy
  has_many :products, through: :products_selling_units

  has_many :goods
end
