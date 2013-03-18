class ApplicationController < ActionController::Base
  before_filter :fetch_cart
  before_filter :set_providers
  before_filter :set_active_user
  before_filter :set_active_cart

  def fetch_cart
    #TODO: Fill with something sensefull!
    @cart ||= Cart.first
    @cart ||= Cart.create
  end

  def set_active_user
    @active_user ||= current_user ||= User.generateGuest
  end

  def set_active_cart
    @active_cart ||= fetchCartFromSession ||= @active_user.carts.create
  end

  def set_providers
     @providers = Provider.all
  end

  protected

  def fetchCartFromSession
    session[:active_cart]
  end

  protect_from_forgery
end
