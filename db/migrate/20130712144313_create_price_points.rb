class CreatePricePoints < ActiveRecord::Migration
  def change
    create_table :price_points do |t|
      t.references :good,       null: false
      t.float      :price,      null: false
      t.integer    :quantity,   null: false

      t.timestamps
    end

    add_index :price_points, :good_id
  end
end
