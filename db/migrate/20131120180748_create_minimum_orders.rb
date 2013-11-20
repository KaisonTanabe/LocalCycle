class CreateMinimumOrders < ActiveRecord::Migration
  def change
    create_table :minimum_orders do |t|
      t.integer :market_id
      t.integer :user_id
      t.float :min_order
      t.timestamps
    end
  end
end
