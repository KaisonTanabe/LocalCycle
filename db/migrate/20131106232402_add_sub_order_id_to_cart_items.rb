class AddSubOrderIdToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :sub_order_id, :string
  end
end
