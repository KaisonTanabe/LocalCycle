class RemoveMarketIdFromGoods < ActiveRecord::Migration
  def up
      remove_column :goods, :market_id 
  end

  def down
  end
end
