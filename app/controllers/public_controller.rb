class PublicController < ApplicationController

  layout 'public'

  def index
    redirect_to agreements_path if user_signed_in?
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

end
