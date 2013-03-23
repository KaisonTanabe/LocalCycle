class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name,    :string,  null: false
    add_column :users, :last_name,     :string,  null: false
    add_column :users, :pin,           :string,  null: false
    add_column :users, :role,          :string,  null: false, default: "educator"
    add_column :users, :active,        :boolean, null: false, default: true
    add_column :users, :phone,         :string
    add_column :users, :notes,         :text
  end
end
