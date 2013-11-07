class EditDeliveryWindowOnSubOrder < ActiveRecord::Migration
  def up
    remove_column :sub_orders, :delivery_window_start
    remove_column :sub_orders, :delivery_window_end
    add_column :sub_orders, :delivery_window_start, :integer
    add_column :sub_orders, :delivery_window_end, :integer

  end

  def down
  end
end
