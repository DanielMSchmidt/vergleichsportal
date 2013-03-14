class ApplicationController < ActionController::Base
  before_filter :fetch_cart

  def fetch_cart
    @cart ||= Cart.first
  end

  protect_from_forgery
end
