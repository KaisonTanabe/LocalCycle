class CreateDeliveryLocations < ActiveRecord::Migration
  def change
    create_table :delivery_locations do |t|
      t.references :market
      t.string     :name

      t.string  :street_address_1
      t.string  :street_address_2
      t.string  :city
      t.string  :state
      t.string  :country,                        default: "US"
      t.string  :zip
      
      t.float   :lat
      t.float   :lng
      t.string  :latlong

      t.timestamps
    end
    
    add_index :delivery_locations, :market_id
  end
end
