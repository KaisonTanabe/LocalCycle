class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.integer    :creator_id,      null: false
      t.integer    :buyer_id,        null: false, default: 0
      t.integer    :producer_id,     null: false, default: 0
      t.references :market,          null: false
      t.references :product,         null: false
      t.references :selling_unit,    null: false
      t.integer    :quantity

      t.boolean    :indefinite,      null: false, default: true
      t.date       :start_date
      t.date       :end_date

      t.timestamps
    end
    
    add_index :goods, :creator_id
    add_index :goods, :buyer_id
    add_index :goods, :producer_id
    add_index :goods, :market_id
    add_index :goods, :product_id
    add_index :goods, :selling_unit_id
  end
end
