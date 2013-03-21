#encoding: utf-8
require 'mechanize'
require 'yaml'

class BuchDeSearch
  #TODO add option support
  #TODO abstract buch_de_search, buecher_de_search, thalia_de_search

  def initialize()
    @provider = YAML.load_file "config/buch_de.yml"
    @agent = Mechanize.new
  end

  def searchByKeywords(searchTerm, options={})
    #Rails.logger.info "BuchDeSearch#searchByKeywords called for #{searchTerm} with #{options}"
    options.delete(:article_type)
    if options.empty?
      links = getArticleLinksFor(searchTerm)
    else
      links = getAdvancedArticleLinksFor(searchTerm, options)
    end

    #filter the providers offers
    links = filterProviderOffer(links)

    #is there a max number of results?
    if options[:count].nil?
      articles = links.collect{|link| getArticleDataFor(link)}
    else
      articles = links.take(options[:count]).collect{|link| getArticleDataFor(link)}
    end

    filterByType(articles, options)

  end

  def getNewestPriceFor(link)
    #Rails.logger.info "BuchDeSearch#getNewestPriceFor called for #{link}"
    getArticleDataFor(link)[:price]
  end



  def getArticleLinksFor(searchTerm)
    #Rails.logger.info "BuchDeSearch#getArticleLinksFor called for #{searchTerm}
    page = @agent.get(@provider[:url])

    search_form = page.form(@provider[:search_form])

    search_form[@provider[:search_field]] = searchTerm

    page = @agent.submit(search_form, search_form.buttons.first)

    links = page.links_with(:class => @provider[:link_class]).collect{|link| link.href}

  end

  def getAdvancedArticleLinksFor(searchTerm, options)
    title =  ((options[:title].nil?) ? '' : options[:title])
    author = ((options[:author].nil?) ? '' : options[:author])
    page = @agent.get('http://www.buch.de/shop/home/suche/?fi=&st='+title+'&sa='+author)
    #st: titel   sa:  autor
    page.links_with(:class => @provider[:link_class]).collect{|link| link.href}
  end

  #Filter links whitch doesnt match with the search
  def filterProviderOffer(links)
    useless_links = links.pop #take the offers
    links.delete(useless_links)
    links
  end

  def filterByType(articles, options)
    if options[:article_type].nil?
      filteredArticles = articles
    else
      articles.each do |element|
        if element.type == options[:article_type]
          filteredArticles = element
        end
      end
    end
    filteredArticles
  end

  def getArticleDataFor(link)
    #Rails.logger.info "BuchDeSearch#getArticleDataFor called for #{link}"
    page = @agent.get(link)
    article = {}
    @provider[:book].each do |key, value|
      article[key] = getItem(page,value)
    end

    article[:url] = link
    article[:image] = page.images.first #TODO: Returns a Mechanize object which can't be handled (url instead plz)
    article[:price] = article[:price].tr(',','.').to_f
    article[:article_type] = getType(page)

    #Rails.logger.info "BuchDeSearch#getArticleDataFor called for #{link} returns #{article}"
    article
  end

  def getType(page)
    providers_type = page.search('.pm_artikeltyp').first.text

    if providers_type == 'Hörbuch' || providers_type == 'CD'
      article_type = 'cd'
    elsif providers_type == 'ebooks'
      article_type = 'ebook'
    elsif providers_type == 'buch'
      article_type = 'book'
    elsif providers_type == 'blu-ray'
      article_type = 'bluray'
    end
    article_type
  end

  def getItem(page, query)
    page.search(query).text
  end
end
