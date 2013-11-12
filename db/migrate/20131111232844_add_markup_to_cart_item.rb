class AddMarkupToCartItem < ActiveRecord::Migration
  def change
    add_column :cart_items, :markup, :float
  end
end
