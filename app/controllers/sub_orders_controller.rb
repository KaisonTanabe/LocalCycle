class SubOrdersController < ApplicationController
load_and_authorize_resource
helper_method :sort_column, :sort_direction

def index
    
  if current_user.producer?
    @sub_orders = SubOrder.where(:producer_id => current_user.id)
  elsif current_user.market_manager?
    @sub_orders = SubOrder.where("market_id in #{current.user.market_ids}" )
  else
    @orders = Order.where('orders.id > -1')
    @sub_orders = SubOrder.where('sub_orders.id > -1')
  end
  @sub_orders = filter_and_sort(@sub_orders, params)

end

def show
end

private

def filter_and_sort(orders, params)
  
  return orders.includes(:order).order(sort_column + " " + sort_direction)
end

def sort_column
  sort = params[:sort] || ''
  (sort !='' || sort == "orders.user_id") ? sort : "created_at"
end

def sort_direction
  direction = params[:direction] || ''
  "ASC DESC".include?(direction) ? direction : "ASC"
end

end