class AddProducerTotalToSubOrder < ActiveRecord::Migration
  def change
    add_column :sub_orders, :producer_total, :float
  end
end
