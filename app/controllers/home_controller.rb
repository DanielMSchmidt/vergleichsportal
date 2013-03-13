class HomeController < ApplicationController
  after_filter :add_query, only: [:search_results]
  def index
    @user = User.new
  end

  def search_results
    @term = params[:search][:term]
    searches = SearchQuery.where(value: @term)

    if searches.empty?
      provider = Provider.all
      results = {}
      provider.each do |single_provider|
        results[single_provider] = HomeController.search(single_provider, @term, params[:search][:options])
      end
      merged_results = HomeController.merge(results)
      @result = merged_results.collect{|article| Article.generate(article)} unless merged_results.nil?
    else
      @result = searches.collect{|search| search.articles}.flatten
    end
  end

  def admin
  end


  protected

  def self.search(provider, search_term, options={})
    instance = eval(provider.name).new
    instance.searchByKeywords(search_term, options)
  end

  def self.merge(hash)
  end

  def add_query
    query = SearchQuery.create(value: @term)
    query.articles = @result unless @result.nil?
  end
end
