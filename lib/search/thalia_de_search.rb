#encoding: utf-8
require 'mechanize'
require 'yaml'

class ThaliaDeSearch
  #TODO abstract buch_de_search, buecher_de_search, thalia_de_search

	def initialize()
		@provider = YAML.load_file "config/thalia_de.yml"
		@agent = Mechanize.new
	end

	def searchByKeywords(searchTerm, options={})
    options.delete(:article_type)
		if options.empty?
      		links = getArticleLinksFor(searchTerm)
    	else
      		links = getAdvancedArticleLinksFor(searchTerm, options)
    	end

      #filter providers offers
      links = filterProviderOffer(links)
    	#is there a max number of results?
    	if options[:count].nil?
      	articles = links.collect{|link| getArticleDataFor(link)}
    	else
      	articles = links.take(options[:count]).collect{|link| getArticleDataFor(link)}
    	end

    	filterByType(articles, options)
	end

	def getArticleLinksFor(searchTerm)
		page = @agent.get(@provider[:url])
		search_form = page.form(@provider[:search_form])
		search_form[@provider[:search_field]] = searchTerm
		page = @agent.submit(search_form, search_form.buttons.first)
		articles = page.links_with(:href => /^http:\/\/www.thalia.de\/shop\/tha_homestartseite\/suchartikel\/.*$/).collect{|link| link.href}.uniq
    articles
  end

	def getNewestPriceFor(link)
    	Rails.logger.info "ThaliaDeSearch#getNewestPriceFor called for #{link}"
    	getArticleDataFor(link)[:price]
 	end

	def getArticleDataFor(link)
		page = @agent.get(link)
		article = {}
		@provider[:book].each do |key, value|
			article[key] = getItem(page,value)
		end
		price_text = page.search(@provider[:price]).text[/\d+,\d+/]
		article[:price] = price_text.tr(',','.').to_f unless price_text.nil?
    article[:url] = link
		details_headlines = page.search(@provider[:detail_headline])
		details_values = page.search(@provider[:detail_value])
		position = details_headlines.collect{|value| value.text}.index("EAN:")
		article[:ean] = details_values[position] if position
		article[:article_type] = getType(page)
		article
	end

	def getAdvancedArticleLinksFor(searchTerm, options)
    title =  ((options[:title].nil?) ? '' : options[:title])
    author = ((options[:author].nil?) ? '' : options[:author])
    page = @agent.get('http://www.thalia.de/shop/tha_homestartseite/suche/?fi=&st='+title+'&sa='+author)
    #st: titel   sa:  autor
   	links = page.links_with(:href => /^http:\/\/www.thalia.de\/shop\/tha_homestartseite\/suchartikel\/.*$/).collect{|link| link.href}
    links
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

	def getItem(page, query)
		item = page.search(query).last
    unless item.nil?
      item = item.text
    end
    item
	end

	def getType(page)
    	provider_type = page.search('.itemSubcategory').text.strip
    	if provider_type == 'Hörbuch' || provider_type == 'Musik'
      		article_type = 'cd'
    	elsif provider_type == 'Film'
      		article_type = 'dvd'
      	elsif provider_type == 'Blu-ray'
      		article_type = 'bluray'
      	elsif provider_type == 'eBook'
      		article_type = 'ebook'
      	elsif provider_type == 'Buch'
      		article_type = 'book'
    	end    		
    	article_type
  	end
end
