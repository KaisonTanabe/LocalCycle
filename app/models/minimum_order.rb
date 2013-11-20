class MinimumOrder < ActiveRecord::Base
  attr_accessible :market_id, :user_id, :min_order
  belongs_to :market
  belongs_to :user
end
