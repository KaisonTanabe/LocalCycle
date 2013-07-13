class AddColumnsForMarkets < ActiveRecord::Migration
  def change
    add_column :users, :market_id, :integer
    add_index :users, :market_id
  end
end
