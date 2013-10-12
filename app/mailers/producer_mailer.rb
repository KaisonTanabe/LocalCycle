class ProducerMailer < ActionMailer::Base

  reply_to = REPLY_TO_ADDRESS

  default from: reply_to
  default reply_to: reply_to
  default cc: 'kaisontanabe@gmail.com'
  
  
  def new_order(user, producer, order)
      @user = user
      @producer = producer
      @order = Order.find(order)
      mail(to: @producer.email, subject: "Order Confirmation - Order: #{@order.transaction.authorization_code}")
    end
    
  def new_demand(good, user, price_point, producer_id)
    @good = Good.find(good)
    @user = user
    @producer = User.find(producer_id)
    
    @qty = price_point.quantity
    @price = price_point.price
    mail(to: @producer.email, subject: "New Demand")
    
  end
  
end


