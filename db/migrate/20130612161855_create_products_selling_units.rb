class CreateProductsSellingUnits < ActiveRecord::Migration
  def change
    create_table :products_selling_units do |t|
      t.references :selling_unit,    null: false
      t.references :product,         null: false
    end

    add_index :products_selling_units, :selling_unit_id
    add_index :products_selling_units, :product_id
  end
end
