class AddBuyerFieldToPricePoints < ActiveRecord::Migration
  def change
    add_column :price_points, :buyers, :text
    remove_column :price_points, :buyer_id
    remove_column :price_points, :market_id
    remove_column :price_points, :network_id

  end
end
