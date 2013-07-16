class CreateMarkets < ActiveRecord::Migration
  def change
    create_table :markets do |t|
      t.string  :name
      t.text    :brief
      t.text    :description
#      t.boolean :complete,                     null: false, default: false

      t.string  :phone

      t.string  :billing_street_address_1
      t.string  :billing_street_address_2
      t.string  :billing_city
      t.string  :billing_state
      t.string  :billing_country,              default: "US"
      t.string  :billing_zip

      t.float   :lat
      t.float   :lng
      t.string  :latlong

      t.string  :website
      t.string  :twitter
      t.string  :facebook

      t.timestamps
    end
  end
end
