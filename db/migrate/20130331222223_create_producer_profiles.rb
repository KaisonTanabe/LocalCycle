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
      
      t.float   :lat
      t.float   :lng
      t.string  :latlong
      
      t.string  :phone
      
      t.text    :description
      t.string  :website
      t.string  :twitter
      t.string  :facebook

      t.integer :size,               null: false, default: 0

      t.integer :growing_methods,    null: false, default: 0
      t.text    :custom_growing_methods

      t.boolean :has_eggs,           null: false, default: false
      t.boolean :has_livestock,      null: false, default: false
      t.boolean :has_dairy,          null: false, default: false
      t.boolean :has_pantry,         null: false, default: false

      t.boolean :text_updates,       null: false, default: true

      t.string  :transport_by

      t.timestamps
    end

    add_index :producer_profiles, :user_id
  end
end
