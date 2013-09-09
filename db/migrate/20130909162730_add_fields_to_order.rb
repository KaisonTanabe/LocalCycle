class AddFieldsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :address_id, :integer
    add_column :orders, :transaction_id, :integer
    add_column :orders, :status, :string
    add_column :orders, :ip_address, :integer
    
    remove_column :orders, :transaction_code
    
    
  end
end
