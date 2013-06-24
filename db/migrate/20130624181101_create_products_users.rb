class CreateProductsUsers < ActiveRecord::Migration
  def change
    create_table :products_users do |t|
      t.references :user,            null: false
      t.references :product,         null: false
    end

    add_index :products_users, :user_id
    add_index :products_users, :product_id
  end
end
