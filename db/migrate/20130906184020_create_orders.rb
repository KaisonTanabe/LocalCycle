class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :buyer_id
      t.float :total
      t.string :transaction_code
      
      t.timestamps
    end
  end
end
