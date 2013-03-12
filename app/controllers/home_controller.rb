class HomeController < ApplicationController
  def index
    @user = User.new
  end

  def search_results

  end

  def admin
  end


  protected

  def search(provider, search_term, options)

  end
end
