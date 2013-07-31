class AddSellingUnitPricePoint < ActiveRecord::Migration
  def up
    add_column :price_points, :selling_unit_id, :integer, null: false, default: 1
    add_column :goods, :available, :boolean, null: false, default: true
    remove_column :goods, :indefinite
  end
  def down
    remove_column :price_points, :selling_unit_id
    remove_column :goods, :available
    add_column :goods, :indefinite, :boolean, null: false, default: false
  end
end
