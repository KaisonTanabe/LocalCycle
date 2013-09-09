class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :card_type
      t.string :name
      t.string :exp
      t.integer :cvv
      t.float :amount
      t.string :authorization_code
      t.timestamps
    end
  end
end
