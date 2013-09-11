class AddCycleToGoods < ActiveRecord::Migration
  def change
    add_column :goods, :cycle, :string
  end
end
