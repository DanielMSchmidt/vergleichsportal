class HomeController < ApplicationController
  def index
  	@user = User.new
  end

  def search_results
  end

  def admin
  end
end
