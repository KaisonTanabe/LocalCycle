class UpdateCartItemFields < ActiveRecord::Migration
  def up
    remove_column :cart_items, :price_point_id
    add_column :cart_items, :good_id, :integer
  end

  def down
  end
end
