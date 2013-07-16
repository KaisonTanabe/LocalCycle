class AddPicToMarket < ActiveRecord::Migration
  def change
    add_attachment :markets,   :pic
  end
end
