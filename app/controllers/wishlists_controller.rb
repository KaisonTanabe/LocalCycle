class WishlistsController < ApplicationController
load_and_authorize_resource

def show
  @good = Good.new()
  @good.price_points.build()
  
  @goods = @wishlist.goods.paginate(page: params[:page], per_page: (params[:per_page] || DEFAULT_PER_PAGE))
  
  
end

end
