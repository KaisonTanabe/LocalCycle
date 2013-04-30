class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string     :name,            null: false
      t.references :category,        null: false
      t.text       :description
      t.date       :start_date,      null: false, default: Date.new(2013,1,1)
      t.date       :end_date,        null: false, default: Date.new(2013,12,31)
      t.string     :unit_type,       null: false, default: "lb"
      t.float      :catch_weight,    null: false, default: "0"

      t.timestamps
    end

    add_index :products, :category_id
  end
end
