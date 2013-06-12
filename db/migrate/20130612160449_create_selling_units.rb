class CreateSellingUnits < ActiveRecord::Migration
  def change
    create_table :selling_units do |t|
      t.string :name,              null: false
      t.string :short_name,        null: false

      t.timestamps
    end

    add_index :selling_units, :name,       unique: true
    add_index :selling_units, :short_name, unique: true
  end
end
