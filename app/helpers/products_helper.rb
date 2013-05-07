module ProductsHelper
  def my_products_path(time="")    
    current_user.producer? ? products_path(producer: current_user.id, status: time) : products_path(buyer: current_user.id, status: time)
  end
end
