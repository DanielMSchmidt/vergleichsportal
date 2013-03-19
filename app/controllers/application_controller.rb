class ApplicationController < ActionController::Base
  before_filter :set_providers
  before_filter :set_active_user
  before_filter :set_active_cart
  before_filter :fetch_add
  after_filter :setGuestUserInSession


  def set_active_user
    #TODO: Save ID of guest sothat it doesnt get lost
    @active_user ||= current_user ||= User.generateGuest
  end

  def set_active_cart
    @active_cart ||= fetchCartFromSession ||= @active_user.carts.create
  end

  def set_providers
     @providers = Provider.all
  end

  def fetch_add
    @active_advertisment ||= Advertisment.where(:active => true).first
    @active_advertisment ||= Advertisment.create(:link_url => "http://tibor-weiss.de", :img_url => "http://tibor-weiss.de/Fotos/2012Schandmaul/Schandmaul/content/images/large/IMG_3408.jpg", :active => true)
  end

  protected

  def fetchCartFromSession
    session[:active_cart]
  end

  def fetchUserFromSession
    session[:guest_user_id]
  end

  def setGuestUserInSession
    session[:guest_user_id] = @guest_user_id
  end

  protect_from_forgery
end
