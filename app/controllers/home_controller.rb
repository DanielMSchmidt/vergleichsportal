class HomeController < ApplicationController
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
      @result = HomeController.search(@term, @options)
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

  def self.search(search_term, options)
    HomeController.searchAtMultipleProviders(Provider.all, search_term, options)
  end

  def self.getAllNewestesPricesFor(query)
    query.articles.each do |article|
      prices = HomeController.getTheNewestPriceFor(article)
      prices.each do |key, value|
        article.prices.create(value: value, provider_id: key)
      end
    end
  end

  def self.getTheNewestPriceFor(article)
    price = {}
    Provider.all.each do |provider|
      price[(provider.id)] = HomeController.getProviderInstance(provider).getNewestPriceFor(article)
    end
    return price
  end

  def self.searchAtMultipleProviders(providers,search_term, options={})
    results = {}
    providers.each do |single_provider|
      results[single_provider] = HomeController.searchAtProvider(single_provider, search_term, options)
    end

    merged_results = HomeController.merge(results)
    merged_results.collect{|article| Article.generate(article)} unless merged_results.nil?
  end

  def self.getProviderInstance(provider)
    (provider.name + "Search").constantize.new
  end

  def self.searchAtProvider(provider, search_term, options={})
    instance = HomeController.getProviderInstance(provider)
    instance.searchByKeywords(search_term, options)
  end

  protected

  def self.merge(search_result)
    # filter empty search_results
    return [] if search_result.nil? || search_result.empty? || search_result.collect{|x| x.empty?}.include?(true)

    search_result.each_with_index do |articles, index|
      articles.each{ |article| article[:provider] = index + 1;}
    end

    HomeController.mergeArticles(HomeController.transformArticle(search_result.flatten))
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

    merged_article[:prices] = HomeController.getMergedAttributes(same_articles, :prices)
    merged_article[:images] = HomeController.getMergedAttributes(same_articles, :images)
    merged_article[:urls] = HomeController.getMergedAttributes(same_articles, :urls)

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
