module ProviderSearch
  def getTheNewestPriceFor(article)
  end
  def getAllNewestesPricesFor(query)
  end


  def searchAtMultipleProviders(providers,search_term, options={})
    results = {}
    providers.each do |single_provider|
      results[single_provider] = searchAtProvider(single_provider, search_term, options)
    end

    merged_results = merge(results)
    merged_results.collect{|article| Article.generate(article)} unless merged_results.nil?
  end
  protected

  def searchAtProvider(provider, search_term, options={})
    instance = (provider.name + "Search").constantize.new
    instance.searchByKeywords(search_term, options)
  end

  def merge(search_result)
    # filter empty search_results
    return [] if search_result.nil? || search_result.empty? || search_result.collect{|x| x.empty?}.include?(true)

    search_result.each_with_index do |articles, index|
      articles.each{ |article| article[:provider] = index + 1;}
    end

    mergeArticles(transformArticle(search_result.flatten))
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