class AddMarketsTableToGoods < ActiveRecord::Migration
  def change
    create_table :goods_markets, id: false do |t|
      t.integer :good_id
      t.integer :market_id
    end
  end
end
