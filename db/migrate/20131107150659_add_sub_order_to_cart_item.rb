class AddSubOrderToCartItem < ActiveRecord::Migration
  def change
    remove_column :cart_items, :sub_order_id
    add_column :cart_items, :sub_order_id, :integer
  end
end
