class AddMarkupToMarket < ActiveRecord::Migration
  def change
    add_column :markets, :markup, :float
  end
end
