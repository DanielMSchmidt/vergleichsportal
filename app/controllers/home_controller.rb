class HomeController < ApplicationController
  after_filter :add_query, only: [:search_results]
  after_filter :filter_results, only: [:search_results]

  def index
  	@user_new = User.new
  	@user_new.role_id = 1
    @providers = Provider.all
  end

  def search_results
    @user_new = User.new
    @user_new.role_id = 1
    @term = params[:search][:term]
    @options = {}
    search = Search.new(@term, @options)
    @result = search.find.reject{|result| result == false} # TODO: Check where nils come from
  end

  def admin
    @users = User.all
    @providers = Provider.all
    @active_advertisments = Advertisment.where(:active => true);
    @inactive_advertisments = Advertisment.where(:active => false);
    @advertisment = Advertisment.new
  end

protected

  def add_query
    query = SearchQuery.create(value: @term)
    query.articles = @result unless @result.nil?
  end

  def filter_results
    Rails.logger.info "HomeController#filter_results called"
    @result.select!{|article| article.available_for_any(Provider.where(active: true))} unless @result.nil?
  end
end
