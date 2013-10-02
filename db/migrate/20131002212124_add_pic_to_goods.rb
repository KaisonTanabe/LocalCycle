class AddPicToGoods < ActiveRecord::Migration
  def change
    add_attachment :goods, :pic
  end
end
