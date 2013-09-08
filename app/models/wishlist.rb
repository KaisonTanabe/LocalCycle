class Wishlist < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  has_many :goods
  
end
