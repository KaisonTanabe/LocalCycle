class AddMarketsToNetwork < ActiveRecord::Migration
  def change
      add_column :markets, :network_id, :integer
    
  end
end
