class AddFieldsToPricePoint < ActiveRecord::Migration
  def change
    add_column :price_points, :network_id, :integer
    add_column :price_points, :market_id, :integer
  end
end
