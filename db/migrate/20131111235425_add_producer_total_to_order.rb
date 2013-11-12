class AddProducerTotalToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :producer_total, :float
  end
end
