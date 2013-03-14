class HomeController < ApplicationController
  def index
  	@user_new = User.new
  	@user_new.role_id = 1
  end

  def search_results
  end

  def admin

    @users = User.all
    @providers = Provider.all
  	@active_advertisments = Advertisment.where(:active => true);
    @inactive_advertisments = Advertisment.where(:active => false);
  	@advertisment = Advertisment.new

  end
end
