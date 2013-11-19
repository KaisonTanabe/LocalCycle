class AddProducerMinOrderToUser < ActiveRecord::Migration
  def change
    add_column :users, :producer_min_order, :float
  end
end
