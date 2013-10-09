class CartsController < ApplicationController
  load_resource


def clear
  @cart.cart_items.each do |ci|
    CartItem.delete(ci.id)
  end
  
  render :partial => 'carts/show', :locals => {cart: @cart}
  
end

def update
  if @cart.update_attributes(params[:cart])
    flash[:notice] = "cart updated"
  else
    flash[:error] =" There was an issue updating your cart"
  end
  
  render :checkout
end

def add_item
   authorize! :update, @cart
   cart_item = @cart.cart_items.where(:good_id => params[:good_id], :market_id => params[:market_id]).first
   
   if cart_item.nil? 
     raise "Must be min order" if(params[:qty].to_i < params[:min_order].to_i) 
     if(Good.find(params[:good_id]).quantity.to_i < params[:qty].to_i)
       render :text => "Not enough quantity available"
        return
     end
     CartItem.create(:good_id => params[:good_id], :quantity => params[:qty], :market_id => params[:market_id], :cart_id => @cart.id)
   else     
     if(Good.find(params[:good_id]).quantity.to_i < cart_item.quantity + params[:qty].to_i)
       render :text => "Not enough quantity available"
        return
     end
     cart_item.quantity = cart_item.quantity + params[:qty].to_i
     cart_item.save
   end
   render :partial => 'carts/show', :locals => {cart: @cart}

end

def remove_item
  CartItem.delete(params[:cart_item_id])
  render :nothing => true
  
end


def checkout
  if @cart.order == nil
    @cart.build_order(:user_id => current_user.id) 
    @cart.save
  end
end

end