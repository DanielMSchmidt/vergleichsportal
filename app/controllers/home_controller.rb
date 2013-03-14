class HomeController < ApplicationController
  include ProviderSearch
  after_filter :add_query, only: [:search_results]

  def index
    @user = User.new
    @user.role_id = 1
  end

  def search_results
    @term = params[:search][:term]
    @options = {}
    searches = SearchQuery.where(value: @term)

    if searches.empty?
      @result = search(@term, @options)
    else
      @result = searches.collect{|search| search.articles}.flatten
    end
  end

  def admin
    @users = User.all
    @providers = Provider.all
    @active_advertisments = Advertisment.where(:active => true);
    @inactive_advertisments = Advertisment.where(:active => false);
    @advertisment = Advertisment.new
  end

  def search(search_term, options)
    searchAtMultipleProviders(Provider.all, search_term, options)
  end

  protected

  def add_query
    query = SearchQuery.create(value: @term)
    query.articles = @result unless @result.nil?
  end
end
