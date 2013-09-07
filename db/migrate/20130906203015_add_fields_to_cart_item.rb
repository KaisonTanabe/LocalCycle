class AddFieldsToCartItem < ActiveRecord::Migration
  def change
    add_column :cart_items, :market_id, :integer
    add_column :cart_items, :sort_order, :integer
  end
end
