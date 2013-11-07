class AddDatesToSubOrder < ActiveRecord::Migration
  def change
    add_column :sub_orders, :market_date, :datetime
    add_column :sub_orders, :delivery_window_start, :datetime
    add_column :sub_orders, :delivery_window_end, :datetime
  end
end
