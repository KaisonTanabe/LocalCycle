class AddCreatedByToProducts < ActiveRecord::Migration
  def change
    add_column :products, :created_by, :integer
  end
end
