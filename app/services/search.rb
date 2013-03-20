class Search

  def initialize(search_term, options={})
    @search_term = search_term
    @options = options
    @provider = Provider.all
  end

  #TODO: Check path without caching for Recursion and test getAllNewestPrices from the console

  def find
    Rails.logger.info "Search#Find called for #{@search_term} with #{@options}"
    searches = SearchQuery.where(value: @search_term)
    unless searches.empty?
      Rails.logger.info "SearchQueries were found: #{searches}"
      return searches.includes(:articles).collect{|search| search.articles}.flatten
    else
      Rails.logger.info "No SearchQueries were found, starting search"
      searchAtMultipleProviders(@provider, @search_term, @options)
    end
  end

  def getAllNewestesPrices(query=SearchQuery.where(value: @search_term, options: @options).first)
    Rails.logger.info "Search#getAllNewestPrices called for #{@search_term} with options: #{@options}"

    if query.nil? || query.articles.empty?
      Rails.logger.info "Search#getAllNewestPrices no query found or no articles in query"
      return false
    end
    query.articles.each do |article|
      prices = getTheNewestPriceFor(article)
      prices.each do |key, value|
        Rails.logger.info "Search#getAllNewestPrices Price created: provider: #{key}, value: #{value}"
        article.prices.create(value: value, provider_id: key)
      end
    end
  end

  def getTheNewestPriceFor(article)
    Rails.logger.info "Search#getTheNewestPriceFor article:#{article}"
    price = {}

    @provider.each do |provider|
      url = article.urls.where(id: provider.id).first
      unless url.nil?
        puts "URL: #{url}"
        price[(provider.id)] = getProviderInstance(provider).getNewestPriceFor(url.value)
      end
    end
    return price
  end

  def searchAtMultipleProviders(providers,search_term, options={})
    Rails.logger.info "Search#searchAtMultipleProviders called for provider: #{providers}, searchTerm: #{search_term}"
    results = []
    #TODO: Maybe change to collect instead
    providers.each do |single_provider|
      results << searchAtProvider(single_provider, search_term, options)
    end
    Rails.logger.info "Search#searchAtMultipleProviders results found: #{results}"
    merged_results = merge(results)
    Rails.logger.info "Search#searchAtMultipleProviders results were merged: #{merged_results}"
    merged_results.collect{|article| Article.generate(article)} unless merged_results.nil?
  end

  def getProviderInstance(provider)
    Rails.logger.info "Search#getProviderInstance called for #{provider.name}"
    (provider.name + "Search").constantize.new
  end

  def searchAtProvider(provider, search_term, options={})
    Rails.logger.info "Search#searchAtProvider called"
    instance = getProviderInstance(provider)
    instance.searchByKeywords(search_term, options)
  end

  def merge(search_result)
    Rails.logger.info "Search#merge called for #{search_result}"
    # filter empty search_results
    return [] if search_result.nil? || search_result.empty?

    search_result.reject!{|provider_results| provider_results.nil? || provider_results.empty?}

    #TODO: Write test for this part, doesn't work jet
    search_result.each_with_index do |articles, provider_index|
      articles.each{ |article| article[:provider] = provider_index + 1;}
    end

    results = filterEmptyArticles(search_result.flatten)

    mergeArticles(transformArticle(results))
  end

  def filterEmptyArticles(articles)
    Rails.logger.info "Search#filterEmptyArticles called for #{articles}"
    no_empty_articles = articles.reject{|article| article[:ean].nil?}
    Rails.logger.info "Search#filterEmptyArticles called and returns #{no_empty_articles}"
    return no_empty_articles
  end

  def transformArticle(all_articles)
    Rails.logger.info "Search#transformArticle called for #{all_articles}"
    #TODO: Refactor
    #FIX ME
    all_articles.each do |article|
      provider = article.delete(:provider)
      article[:images] ||= {provider => article.delete(:image)}
      article[:prices] ||= {provider => article.delete(:price)}
      article[:urls] ||= {provider => article.delete(:url)}
    end
    return all_articles
  end

  def mergeArticles(articles)
    Rails.logger.info "Search#mergeArticles called for #{articles}"
    #TODO: Refactor
    merged_articles = []

    while articles.count > 0 do
      article = articles.first
      same_articles = articles.select{|x| x[:ean] == article[:ean] }
      merged_articles << mergeArticle(same_articles)
      same_articles.each{|single_article| articles.delete(single_article)}
    end

    merged_articles
  end

  def mergeArticle(same_articles)
    Rails.logger.info "Search#mergeArticle called for #{same_articles}"
    merged_article = same_articles.first

    merged_article[:prices] = getMergedAttributes(same_articles, :prices)
    merged_article[:images] = getMergedAttributes(same_articles, :images)
    merged_article[:urls] = getMergedAttributes(same_articles, :urls)

    merged_article
  end

  def getMergedAttributes(articles, attribute)
    Rails.logger.info "Search#getMergedAttributes called for #{articles} with attributes #{attribute}"
    attrib = {}
    articles.collect{|x| x[attribute]}.each{|x| attrib.merge!(x)}
    attrib
  end
end