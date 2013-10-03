class AddDefaulOrderCutoffToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_cutoff, :integer
  end
end
