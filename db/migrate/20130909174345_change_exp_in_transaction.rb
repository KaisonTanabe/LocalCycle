class ChangeExpInTransaction < ActiveRecord::Migration
  def up
    remove_column :transactions, :exp
    add_column :transactions, :exp_month, :string
    add_column :transactions, :exp_year, :string

  end

  def down
  end
end
