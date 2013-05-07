class AlterAgreements < ActiveRecord::Migration
  def up
    change_column :agreements, :buyer_id, :integer, null: false, default: 0
    change_column :agreements, :producer_id, :integer, null: false, default: 0
  end

  def down
    change_column :agreements, :buyer_id, :integer, null: true, default: nil
    change_column :agreements, :producer_id, :integer, null: true, default: nil
  end
end
