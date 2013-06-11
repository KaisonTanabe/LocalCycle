class RemoveNullFromAgreementQuantity < ActiveRecord::Migration
  def up
    change_column :agreements, :quantity, :integer,  null: true
  end

  def down
    change_column :agreements, :quantity, :integer,  null: false
  end
end
