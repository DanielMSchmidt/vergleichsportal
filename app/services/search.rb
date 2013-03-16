class Search

  def initialize(search_term, options={})
    @search_term = search_term
    @options = options
  end

  def find
    searches = SearchQuery.where(value: @search_term)
    return searches.collect{|search| search.articles}.flatten unless searches.empty?
    searchAtMultipleProviders(Provider.all, @search_term, @options)
  end

  def getAllNewestesPrices
    query.articles.each do |article|
      prices = getTheNewestPriceFor(article)
      prices.each do |key, value|
        article.prices.create(value: value, provider_id: key)
      end
    end
  end

  def getTheNewestPriceFor(article)
    price = {}
    Provider.all.each do |provider|
      price[(provider.id)] = getProviderInstance(provider).getNewestPriceFor(article)
    end
    return price
  end

  def searchAtMultipleProviders(providers,search_term, options={})
    results = []
    #TODO: Maybe change to collect instead
    providers.each do |single_provider|
      results << searchAtProvider(single_provider, search_term, options)
    end

    merged_results = merge(results)
    merged_results.collect{|article| Article.generate(article)} unless merged_results.nil?
  end

  def getProviderInstance(provider)
    (provider.name + "Search").constantize.new
  end

  def searchAtProvider(provider, search_term, options={})
    instance = getProviderInstance(provider)
    instance.searchByKeywords(search_term, options)
  end

  def merge(search_result)
    # filter empty search_results
    return [] if search_result.nil? || search_result.empty? || search_result.collect{|x| x.empty?}.include?(true)

    #TODO: Write test for this part, doesn't work jet
    search_result.each_with_index do |articles, provider_index|
      articles.each{ |article| article[:provider] = provider_index + 1;}
    end

    results = filterEmptyArticles(search_result.flatten)

    mergeArticles(transformArticle(results))
  end

  def filterEmptyArticles(articles)
    articles.reject{|article| article[:ean].nil?}
  end

  def transformArticle(all_articles)
    #TODO: Refactor
    all_articles.each do |article|
      provider = article.delete(:provider)
      article[:images] ||= {provider => article.delete(:image)}
      article[:prices] ||= {provider => article.delete(:price)}
      article[:urls] ||= {provider => article.delete(:url)}
    end
    return all_articles
  end

  def mergeArticles(articles)
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

  def mergeArticle(same_articles)
    merged_article = same_articles.first

    merged_article[:prices] = getMergedAttributes(same_articles, :prices)
    merged_article[:images] = getMergedAttributes(same_articles, :images)
    merged_article[:urls] = getMergedAttributes(same_articles, :urls)

    merged_article
  end

  def getMergedAttributes(articles, attribute)
    attrib = {}
    articles.collect{|x| x[attribute]}.each{|x| attrib.merge!(x)}
    attrib
  end

end