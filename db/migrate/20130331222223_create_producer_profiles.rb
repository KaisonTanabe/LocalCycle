class CreateProducerProfiles < ActiveRecord::Migration
  def change
    create_table :producer_profiles do |t|
      t.references :user

      t.string  :name,               null: false

      t.string  :street_address_1,   null: false
      t.string  :street_address_2
      t.string  :city,               null: false
      t.string  :state,              null: false
      t.string  :country,            null: false, default: "US"
      t.string  :zip,                null: false
      
      t.float   :latitude
      t.float   :longitude
      
      t.string  :phone
      
      t.text    :description
      t.string  :website
      t.string  :twitter
      t.string  :facebook

      t.string  :growing_methods,  null: false, default: "none"

      t.boolean :has_eggs,         null: false, default: false
      t.boolean :has_livestock,    null: false, default: false
      t.boolean :has_dairy,        null: false, default: false
      t.boolean :has_pantry,       null: false, default: false

      t.timestamps
    end
    add_index :producer_profiles, :user_id
  end
end
