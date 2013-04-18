class AddPicToProducts < ActiveRecord::Migration
  def change
    add_attachment :products, :pic
  end
end
