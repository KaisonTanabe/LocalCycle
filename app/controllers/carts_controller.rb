class CartsController < ApplicationController
  load_resource


def clear
  @cart.cart_items.each do |ci|
    CartItem.delete(ci.id)
  end
  
  render :partial => 'carts/show', :locals => {cart: @cart}
  
end

def add_item
   authorize! :update, @cart
   cart_item = @cart.cart_items.where(:good_id => params[:good_id], :market_id => params[:market_id]).first
   
   if cart_item.nil? 
     raise "Must be min order" if(params[:qty].to_i < params[:min_order].to_i) 
     
     CartItem.create(:good_id => params[:good_id], :quantity => params[:qty], :market_id => params[:market_id], :cart_id => @cart.id)
   else     
     if(params[:qty].to_i < cart_item.quantity + params[:qty].to_i)
       render :text => "Not enough quantity available"
        return
     end
     cart_item.quantity = cart_item.quantity + params[:qty].to_i
     cart_item.save
   end
   render :partial => 'carts/show', :locals => {cart: @cart}

end


def checkout
  if @cart.order == nil
    @cart.build_order(:user_id => current_user.id) 
    @cart.save
  end
end

end