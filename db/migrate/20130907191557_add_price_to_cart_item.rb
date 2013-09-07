class AddPriceToCartItem < ActiveRecord::Migration
  def change
    add_column :cart_items, :price, :float
  end
end
