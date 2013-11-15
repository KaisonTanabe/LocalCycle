class CartsController < ApplicationController
  load_resource
include ActionView::Helpers::NumberHelper

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
   
   calc_use = 0
   @cart.cart_items.where(:good_id => params[:good_id]).each do |v|
    calc_use = calc_use + v.quantity
   end
   
   if cart_item.nil? 
     raise "Must be min order" if(params[:qty].to_i < params[:min_order].to_i) 
     if(!Good.find(params[:good_id]).no_qty && Good.find(params[:good_id]).quantity.to_i < params[:qty].to_i)
       render :text => "Not enough quantity available"
        return
     end
     CartItem.create(:good_id => params[:good_id], :quantity => params[:qty], :market_id => params[:market_id], :cart_id => @cart.id, :markup=> (Market.find(params[:market_id]).markup == nil ? 0 : Market.find(params[:market_id]).markup))
   else     
     if(!Good.find(params[:good_id]).no_qty && Good.find(params[:good_id]).quantity.to_i < calc_use + params[:qty].to_i)
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
  items = current_user.get_cart.cart_items.sort! { |a,b| a.market.name.downcase <=> b.market.name.downcase }
	items.collect{|ci| ci.market}.uniq.each do |market|
	  
	  market_total = 0.0
		@cart.cart_items.where(:market_id => market.id).each do |item|
			 market_total = market_total + ((item.price+ (item.price*item.markup/100)) * item.quantity)
		end
		market_total = market_total + market.distribution_fee
		if market_total < (market.order_min == nil ? 0 : market.order_min)
	    flash[:error] = "#{market.name} minimum order is #{number_to_currency(market.order_min)}. Please add more to your cart to checkout." 
	    redirect_to :back
	  end
	  
	end
	
    
  if @cart.order == nil
    @cart.build_order(:user_id => current_user.id) 
    @cart.save
  end
end

end