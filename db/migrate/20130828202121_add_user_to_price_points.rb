class AddUserToPricePoints < ActiveRecord::Migration
  def change
    add_column :price_points, :buyer_id, :integer
  end
end
