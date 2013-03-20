class ApplicationController < ActionController::Base
  before_filter :set_providers
  before_filter :set_active_user
  before_filter :set_active_cart
  before_filter :set_user_carts
  before_filter :fetch_add

  after_filter :setGuestUserInCookies
  after_filter :setActiveCartInCookies


  def set_active_user
    Rails.logger.info "ApplicationController#set_active_user called"
    @active_user ||= current_user           # There is a logged in user
    @active_user ||= fetchUserFromCookies   # There was allready a guest user created
    @active_user ||= User.generateGuest     # Last chance: create a new guest user
    Rails.logger.info "ApplicationController#set_active_user returns #{@active_user}"
  end

  def set_active_cart
    @active_cart ||= fetchCartFromCookies
    @active_cart ||= @active_user.carts.last_used.first unless @active_user.carts.empty?
    @active_cart ||= @active_user.carts.create
  end

  def set_user_carts
    @user_carts = @active_user.carts
  end

  def set_providers
     @providers = Provider.all
  end

  def fetch_add
    @active_advertisment ||= Advertisment.where(:active => true).first
    @active_advertisment ||= Advertisment.new(:link_url => "http://placehold.it", :img_url => "http://placehold.it/205x300&text=Werbung.png", :active => true)
  end

  protected

  def fetchCartFromCookies
    Rails.logger.info "ApplicationController#fetchCartFromCookies called and fetched #{cookies[:active_cart]}"
    begin
      cart = Cart.find(cookies[:active_cart]) unless cookies[:active_cart].nil?
      cart if cart.user == @active_user
    rescue
      nil
    end
    nil
  end

  def fetchUserFromCookies
    Rails.logger.info "ApplicationController#fetchUserFromCookies called and fetched #{cookies[:guest_user_id]}"
    user_id = cookies[:guest_user_id]
    return nil if user_id.nil?
    begin
      Rails.logger.info "User found"
      user = User.find(user_id)
      return user if user.guest?
    rescue
      Rails.logger.info "User not found"
      nil
    end
  end

  def setGuestUserInCookies
    unless logged_in?
      #The active user is a guest
      cookies[:guest_user_id] = @active_user.id
    end
    Rails.logger.info "ApplicationController#setGuestUserInCookies called and wrote #{cookies[:guest_user_id]} to sesion"
  end

  def setActiveCartInCookies
    cookies[:active_cart] = @active_cart.id
  end

  protect_from_forgery
end
