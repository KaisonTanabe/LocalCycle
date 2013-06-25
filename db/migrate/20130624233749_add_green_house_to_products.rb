class AddGreenHouseToProducts < ActiveRecord::Migration
  def change
    add_column :products, :greenhouse_grown, :boolean, null: false, default: false
  end
end
