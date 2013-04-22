class AddPicToProducts < ActiveRecord::Migration
  def change
    add_attachment :products, :pic
    add_attachment :categories, :pic
    add_attachment :buyer_profiles, :pic
    add_attachment :producer_profiles, :pic
  end
end
