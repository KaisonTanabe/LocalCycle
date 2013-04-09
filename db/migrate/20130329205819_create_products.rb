class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string     :name,            null: false
      t.references :category,        null: false
      t.text       :description
      t.string     :unit_type,       null: false, default: "lb"
      t.float      :catch_weight,    null: false, default: "0"
      

      t.timestamps
    end

    add_index :products, :category_id
  end
end
