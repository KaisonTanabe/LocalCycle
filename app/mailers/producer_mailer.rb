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
end


