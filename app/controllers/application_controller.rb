class ApplicationController < ActionController::Base
  before_filter :fetch_cart

  def fetch_cart
    #TODO: Fill with something sensefull!
    @cart ||= Cart.first
    @cart ||= Cart.create
  end

  def active_user
    @active_user ||= current_user ||= User.generateGuest
  end

  protect_from_forgery
end
