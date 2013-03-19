class ApplicationController < ActionController::Base
  before_filter :fetch_cart, :fetch_add, :fetch_providers

  def fetch_cart
    #TODO: Fill with something sensefull!
    @cart ||= Cart.first
    @cart ||= Cart.create
  end

  def fetch_add
    @active_advertisment ||= Advertisment.where(:active => true).first
    @active_advertisment ||= Advertisment.new(:link_url => "http://placehold.it", :img_url => "http://placehold.it/205x300&text=Werbung.png", :active => true)
  end

  def fetch_providers
    @providers = Provider.all
  end

  protect_from_forgery
end
