class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :markets_users, :id => false do |t|
        t.integer :market_id
        t.integer :user_id
    end
  
  end
end
