class PublicController < ApplicationController

  layout 'public'

  def index
    redirect_to products_path if user_signed_in?
  end

  def faq
  end

  def about
  end

  def contact
  end

  def test
  end

end
