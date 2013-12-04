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
  authorize! :update, @cart
  @cart.assign_attributes(params[:cart])
  
  @cart.cart_items.each do |item|
    
      price_point = Hash.new 
  		item.good.price_points.each do |pp|		
  			if JSON.parse(pp.buyers)["#{item.market.id.to_s}"] != nil
  				 if (JSON.parse(pp.buyers)["#{item.market.id.to_s}"].count == 0 )
  					 price_point["#{pp.quantity.to_s}"] = pp if price_point["#{pp.quantity.to_s}"] == nil
  				else
  						 if (JSON.parse(pp.buyers)["#{item.market.id.to_s}"].include? ("#{@cart.user.id.to_s}"))
  								 price_point["#{pp.quantity.to_s}"] = pp 
  						end
  				end			
  			end
  		end				
	
		  price_holder = nil
  		 price_point.keys.sort.each do |key|
  			 pp = price_point[key]
  			 if (item.quantity >= key.to_i)
  			   price_holder = pp.price 
  		   end
  		end
    
      if(price_holder == nil ) 
        flash[:error] = "Must have min order of #{price_point.keys.sort.first} for #{item.good.name}"
        redirect_to :back
        return
      end
    
      if(!Good.find(item.good_id).no_qty && Good.find(item.good_id).quantity.to_i < item.quantity)
          flash[:error] =  "Not enough quantity available for #{item.good.name}"
          redirect_to :back
         return
      end
  end
  
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
	  else
	    producer_hash = Hash.new
  	  items.each do |i|
  	    
  	    producer_hash[i.good.creator_id] = Hash.new if(!producer_hash.keys.include?(i.good.creator_id))
  	    producer_hash[i.good.creator_id][i.market_id] = 0 if(!producer_hash[i.good.creator_id].keys.include?(i.market_id))
        producer_hash[i.good.creator_id][i.market_id] = producer_hash[i.good.creator_id][i.market_id] + (i.price+ (i.price*i.markup/100)) * i.quantity
      end
      producer_hash.keys.each do |key|
        producer_hash[key].keys.each do |market|
          if producer_hash[key][market] < ( User.find(key).minimum_orders.where(:market_id=>market).first ? User.find(key).minimum_orders.where(:market_id=>market).first.min_order : 0)+ (( User.find(key).minimum_orders.where(:market_id=>market).first ? User.find(key).minimum_orders.where(:market_id=>market).first.min_order : 0)*Market.find(market).markup/100)
            flash[:error] = "#{User.find(key).name} requires a minimum order of #{number_to_currency(( User.find(key).minimum_orders.where(:market_id=>market).first ? User.find(key).minimum_orders.where(:market_id=>market).first.min_order : 0)+ (( User.find(key).minimum_orders.where(:market_id=>market).first ? User.find(key).minimum_orders.where(:market_id=>market).first.min_order : 0)*Market.find(market).markup/100) )} for #{Market.find(market).name}." 
      	    redirect_to :back

          end
          
        end
      end
	  end
	end
	
    
  if @cart.order == nil
    @cart.build_order(:user_id => current_user.id) 
    @cart.save
  end
end

end