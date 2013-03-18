class ApplicationController < ActionController::Base
  before_filter :fetch_cart, :fetch_add

  def fetch_cart
    #TODO: Fill with something sensefull!
    @cart ||= Cart.first
    @cart ||= Cart.create
  end

  def fetch_add
    @active_advertisment ||= Advertisment.where(:active => true)
    @active_advertisment ||= Advertisment.create(:link_url => "http://tibor-weiss.de", :img_url => "http://tibor-weiss.de/Fotos/2012Schandmaul/Schandmaul/content/images/large/IMG_3408.jpg", :active => true)
  end

  protect_from_forgery
end
