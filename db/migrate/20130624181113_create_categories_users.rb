class CreateCategoriesUsers < ActiveRecord::Migration
  def change
    create_table :categories_users do |t|
      t.references :user,            null: false
      t.references :category,        null: false
    end

    add_index :categories_users, :user_id
    add_index :categories_users, :category_id
  end
end
