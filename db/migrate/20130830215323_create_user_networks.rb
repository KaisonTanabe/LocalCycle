class CreateUserNetworks < ActiveRecord::Migration
  def change
    create_table :user_networks do |t|
      t.integer :network_id
      t.integer :user_id
      t.boolean :approved
      t.timestamps
    end
  end
end
