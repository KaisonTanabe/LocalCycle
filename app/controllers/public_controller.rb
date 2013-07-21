class PublicController < ApplicationController

  layout 'public', except: "placeholder"
  layout 'placeholder', only: "placeholder"

  def index
    redirect_to goods_path if user_signed_in?
  end

  def for_farmers
  end

  def for_buyers
  end

  def about_us
  end

  def contact
  end

  def test
  end

  def placeholder
  end

end
