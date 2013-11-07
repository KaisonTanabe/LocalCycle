class CreateSubOrders < ActiveRecord::Migration
  def change
    create_table :sub_orders do |t|
      t.integer :order_id
      t.integer :key
      t.integer :market_id
      t.integer :producer_id
      t.float :dist_cost
      t.float :total
      t.timestamps
    end
  end
end
