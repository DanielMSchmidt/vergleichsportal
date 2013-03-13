class HomeController < ApplicationController
  def index
  	@user = User.new
  	@user.role_id = 1
  end

  def search_results
  end

  def admin

    @users = User.all
  	@advertisments = Advertisment.all
  	@advertisment = Advertisment.new

  end
end
