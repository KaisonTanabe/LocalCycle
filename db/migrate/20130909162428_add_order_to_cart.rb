class AddOrderToCart < ActiveRecord::Migration
  def change
    add_column :carts, :order_id, :integer
  end
end
