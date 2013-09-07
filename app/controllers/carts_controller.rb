class CartsController < ApplicationController
  load_resource


def add_item
   authorize! :update, @cart
   cart_item = @cart.cart_items.where(:good_id => params[:good_id]).first
   if cart_item.nil? 
     @cart.cart_items << CartItem.create(:good_id => params[:good_id], :quantity => params[:qty], :market_id => 1)
   else     
     cart_item.quantity = cart_item.quantity + params[:qty].to_i
     cart_item.save
   end
   render :partial => 'carts/show', :locals => {cart: @cart}

end

end