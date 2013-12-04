class ProducerMailer < ActionMailer::Base

  reply_to = REPLY_TO_ADDRESS

  default from: reply_to
  default reply_to: reply_to
  default cc: 'kaisontanabe@gmail.com'
  
  
  def new_order(user, producer, sub_order)
      @user = user
      @producer = producer
      @sub_order = SubOrder.find(sub_order)
      mail(to: @producer.email, subject: "Order Confirmation - Sub Order: #{@sub_order.order_id}_#{ ('a'..'z').to_a[@sub_order.key].upcase }")
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


