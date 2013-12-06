class SubOrder < ActiveRecord::Base
  attr_accessible  :order_id, :key, :market_id, :producer_id, :dist_cost, :total, :market_date, :delivery_window_day, :delivery_window_start, :delivery_window_end, :producer_total
  belongs_to :order
  belongs_to :market
  belongs_to :user, :foreign_key => 'producer_id'
  has_many :cart_items


  def producer
    User.find(producer_id)
  end

end
