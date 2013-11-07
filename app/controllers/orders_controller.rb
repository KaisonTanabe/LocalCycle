class OrdersController < ApplicationController
load_and_authorize_resource
helper_method :sort_column, :sort_direction

def index
  if current_user.buyer?
    @orders = Order.where(:user_id => current_user.id)
    @sub_orders = Array.new
    @orders.each do |o|
      @sub_orders = @sub_orders + o.sub_orders
    end
  elsif current_user.admin?
    @orders = Order.where('id > -1')
    @sub_orders = SubOrder.where('id > -1')
  end
  @orders = filter_and_sort(@orders, params)

end

def show
end

def edit
  @order.build_transaction
  if (@order.address == nil)
    @order.build_address
  end
  render :billing
  
end

def update
  if @order.update_attributes(params[:order])
    transaction = AuthorizeNet::AIM::Transaction.new(ANET_API_LOGIN_ID, ANET_KEY,
      :gateway => ANET_GATEWAY)
      
    transaction.set_fields({:invoice_num => @order.id})
    
    
    credit_card = AuthorizeNet::CreditCard.new(@order.transaction.credit_card, @order.transaction.get_exp)
    
    response = transaction.purchase( @order.total, credit_card)
    
    if response.success?
      @order.finalize_transaction(response.authorization_code)
      
      @order.cart_items.includes(:good).collect{|ci| ci.good.creator_id}.uniq.each do |producer|
     	  ProducerMailer.new_order(current_user, User.find(producer), @order.id).deliver
     	end
     	
     	@order = Order.find(@order.id)
     	
     	@order.cart_items.map{|ci| ci.market_id}.uniq.each do |market|
     	  BuyerMailer.checkout(current_user, @order.id, Market.find(market)).deliver
        
   	  end
   	  
      
      puts "PROVIDER: #{@order.cart_items.to_yaml}"
     

     	
		
      render :success 
    else
      flash.now[:error] = "There was an error while processing your payment. #{response.response_reason_text}"
      render :billing
    end
  else
    render :billing
  end
  
    
end

private

def filter_and_sort(orders, params)
  
  return orders.order(sort_column + " " + sort_direction)
end

def sort_column
  sort = params[:sort] || ''
  (sort !='') ? sort : "created_at"
end

def sort_direction
  direction = params[:direction] || ''
  "ASC DESC".include?(direction) ? direction : "ASC"
end

end