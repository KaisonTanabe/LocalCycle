class CreateBuyerProfiles < ActiveRecord::Migration
  def change
    create_table :buyer_profiles do |t|
      t.references :user

      t.string  :name,               null: false

      t.string  :street_address_1,   null: false
      t.string  :street_address_2
      t.string  :city,               null: false
      t.string  :state,              null: false
      t.string  :country,            null: false, default: "US"
      t.string  :zip,                null: false
      
      t.float   :lat
      t.float   :lng
      t.float   :latlong
      
      t.string  :phone
      
      t.text    :description
      t.string  :website
      t.string  :twitter
      t.string  :facebook

      t.boolean :text_updates,       null: false, default: true

      t.string  :transport_by

      t.timestamps
    end
    add_index :buyer_profiles, :user_id
  end
end
