class AddProducerToPricePoint < ActiveRecord::Migration
  def change
    add_column :price_points, :producer_id, :integer
  end
end
