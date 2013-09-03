class AddFieldsToMarket < ActiveRecord::Migration
  def change
    add_column :markets, :day_of_week, :integer
    add_column :markets, :cycle, :integer
    add_column :markets, :start_time, :time
    add_column :markets, :end_time, :time
    add_column :markets, :all_buyers, :boolean
  end
end
