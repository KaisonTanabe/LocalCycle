class ChangeBuyerIdInOrder < ActiveRecord::Migration
  def up
    remove_column :orders, :buyer_id
    add_column :orders, :user_id, :integer
  end

  def down
  end
end
