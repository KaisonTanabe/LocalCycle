class BuyerMailer < ActionMailer::Base

  reply_to = REPLY_TO_ADDRESS

  default from: reply_to
  default reply_to: reply_to
  default cc: 'kaisontanabe@gmail.com'
  
  def checkout(user, order, market)
      @user = user
      @order = Order.find(order)
      @market = Market.find(market)
      mail(to: @user.email, subject: "Order Confirmation - Order: #{@order.transaction.authorization_code}")
    end

  def new_pricepoint(user, price_point, market)
      @user = user
      @price_point = price_point
      @market = market
      @producer = User.find(@price_point.good.creator_id).name
      mail(to: @user.email, subject: 'New Price Available to You!')
  end

end


