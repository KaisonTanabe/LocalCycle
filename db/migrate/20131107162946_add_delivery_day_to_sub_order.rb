class AddDeliveryDayToSubOrder < ActiveRecord::Migration
  def change
    add_column :sub_orders, :delivery_window_day, :integer
  end
end
