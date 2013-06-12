class ProductsSellingUnit < ActiveRecord::Base

  belongs_to :selling_unit
  belongs_to :product


  attr_accessible :product_id, :selling_unit_id

end
