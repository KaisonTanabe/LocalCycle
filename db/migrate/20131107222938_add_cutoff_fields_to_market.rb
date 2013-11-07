class AddCutoffFieldsToMarket < ActiveRecord::Migration
  def change
    add_column :markets, :start_orders, :integer
    add_column :markets, :end_orders, :integer
  end
end
