class AddNoQtyToGoods < ActiveRecord::Migration
  def change
    add_column :goods, :no_qty, :boolean
  end
end
