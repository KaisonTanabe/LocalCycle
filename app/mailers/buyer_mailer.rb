class BuyerMailer < ActionMailer::Base

  reply_to = REPLY_TO_ADDRESS

  default from: reply_to
  default reply_to: reply_to
  
  def checkout(user, order)
      @user = user
      @order = order
      mail(to: @user.email, subject: 'Order Confirmation - Order: #{order.transaction.authorization_code}')
    end
end


