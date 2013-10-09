class WishlistsController < ApplicationController
load_and_authorize_resource

def show
  @good = Good.new()
  @good.price_points.build()
  
  @goods = @wishlist.goods.paginate(page: params[:page], per_page: (params[:per_page] || DEFAULT_PER_PAGE))
  
  
end


def index 
  @price_points = PricePoint.where(:producer_id => current_user.id) + PricePoint.where(:producer_id => -1)
  
  @goods = @price_points.collect{|p| p.good}
  
end

end
