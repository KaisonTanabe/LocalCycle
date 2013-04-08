class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.integer :parent_id
      t.integer :fakeid

      t.timestamps
    end
  end
end
