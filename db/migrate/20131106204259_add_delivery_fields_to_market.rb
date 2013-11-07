class AddDeliveryFieldsToMarket < ActiveRecord::Migration
  def change
    add_column :markets, :order_min, :float
    add_column :markets, :distribution_fee, :float
    
     
  end
end
