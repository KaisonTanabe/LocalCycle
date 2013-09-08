class CreateGoodsWishlists < ActiveRecord::Migration
  def up
    add_column :goods, :wishlist_id, :integer
    
  end

  def down
  end
end
