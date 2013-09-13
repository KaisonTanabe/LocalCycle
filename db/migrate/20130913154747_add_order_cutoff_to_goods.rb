class AddOrderCutoffToGoods < ActiveRecord::Migration
  def change
    add_column :goods, :order_cutoff, :integer
  end
end
