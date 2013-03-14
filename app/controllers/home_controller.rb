class HomeController < ApplicationController
  after_filter :add_query, only: [:search_results]
  def index
  	@user = User.new
  	@user.role_id = 1
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

    @users = User.all
    @providers = Provider.all
  	@active_advertisments = Advertisment.where(:active => true);
    @inactive_advertisments = Advertisment.where(:active => false);
  	@advertisment = Advertisment.new

  end


  protected

  def self.search(provider, search_term, options={})
    instance = eval(provider.name).new
    instance.searchByKeywords(search_term, options)
  end

  def self.merge(search_result)
    # filter empty search_results
    return [] if search_result.nil? || search_result.empty? || search_result.collect{|x| x.empty?}.include?(true)

    search_result.each_with_index do |articles, index|
      articles.each{ |article| article[:provider] = index + 1;}
    end

    mergeArticles(transformArticle(search_result.flatten))
  end

  def self.transformArticle(all_articles)
    #TODO: Refactor
    all_articles.each do |article|
      provider = article.delete(:provider)
      article[:images] ||= {provider => article.delete(:image)}
      article[:prices] ||= {provider => article.delete(:price)}
      article[:urls] ||= {provider => article.delete(:url)}
    end
    return all_articles
  end

  def self.mergeArticles(articles)
    #TODO: Refactor
    merged_articles = []

    while articles.count > 0 do
      article = articles.first
      same_articles = articles.select{|x| x[:ean] == article[:ean] }
      merged_articles << mergeArticle(same_articles)
      same_articles.each{|article| articles.delete(article)}
    end

    merged_articles
  end

  def self.mergeArticle(same_articles)
    merged_article = same_articles.first

    merged_article[:prices] = getMergedAttributes(same_articles, :prices)
    merged_article[:images] = getMergedAttributes(same_articles, :images)
    merged_article[:urls] = getMergedAttributes(same_articles, :urls)

    merged_article
  end

  def self.getMergedAttributes(articles, attribute)
    attrib = {}
    articles.collect{|x| x[attribute]}.each{|x| attrib.merge!(x)}
    attrib
  end

  def add_query
    query = SearchQuery.create(value: @term)
    query.articles = @result unless @result.nil?
  end
end
