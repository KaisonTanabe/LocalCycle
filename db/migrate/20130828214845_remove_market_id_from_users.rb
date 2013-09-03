class RemoveMarketIdFromUsers < ActiveRecord::Migration
  def up
    
    
    change_table :users do |t|
      t.remove :market_id
    end
    
    
  end

  def down
  end
end
