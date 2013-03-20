#encoding: utf-8
require 'mechanize'
require 'yaml'

class BuecherDeSearch

	def initialize()
		@provider = YAML.load_file "config/buecher_de.yml"
		@agent = Mechanize.new
	end

	def searchByKeywords(searchTerm, options={})
		if options.empty?
      		links = getArticleLinksFor(searchTerm)
    	else
      		links = getAdvancedArticleLinksFor(searchTerm, options)
    	end

    	#is there a max number of results?
    	if options[:count].nil?
      		articles = links.collect{|link| getArticleDataFor(link)}
    	else
      		articles = links.take(options[:count]).collect{|link| getArticleDataFor(link)}
    	end

    	filterByType(articles, options)
	end

	def getNewestPriceFor(link)
    	#Rails.logger.info "ThailaDeSearch#getNewestPriceFor called for #{link}"
    	getArticleDataFor(link)[:price]
 	end

	def getArticleLinksFor(searchTerm)
		page = @agent.get(@provider[:url])

		search_form = page.form(@provider[:search_form])

		search_form[@provider[:search_field]] = searchTerm

		page = @agent.submit(search_form, search_form.buttons.first)

		books = page.links_with(:class => "booklink").collect{|link| link.href}
	end

	def getArticleDataFor(link)
		page = @agent.get(link)
		article = {}
		@provider[:book].each do |key, value|
			article[key] = getItem(page,value)
		end
		page.search(@provider[:produktinfo]).each do |value|
			value_array = value.text.split(": ")
			article[:ean] =  value_array[1] if value_array[0] == 'ISBN-13'
		end
		
		article[:price] = page.search(@provider[:price]).to_s[/\d+,\d+/].tr(',','.').to_f
		article[:image_url] = page.images.at(5)
		article[:url] = link
		article[:article_type] = getType(page)
		article
	end

	def getAdvancedArticleLinksFor(searchTerm, options)
		page = agent.get('http://www.buecher.de/go/search_search/expert_search/lfa/quicksearchform/')
		search_form = page.form(:action => 'http://www.buecher.de/go/search_search/expert_search_result/receiver_object/shop_search_expertsearch/')
		search_form['form[personen]'] =  ((options[:author].nil?) ? '' : options[:author])
		search_form['form[schlagworte]'] = ((options[:title].nil?) ? '' : options[:title])
		page = agent.submit(search_form, search_form.buttons.first)
		articles=  page.links_with(:class => "booklink").collect{|link| link.href}
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
		item = page.search(query).first
		unless item.nil?
			item = item.text
		end
		item
	end

	def getType(page)
		provider_type = page.search('#produkttyp')
		provider_type = provider_type.text
		provider_type = provider_type.strip
		if provider_type == 'Audio CD'
			article_type = 'cd'
    	elsif provider_type == 'eBook, ePUB'
    		article_type = 'ebook'
    	elsif provider_type == 'Gebundenes Buch' || provider_type == 'Broschiertes Buch'
      		article_type = 'book'
    	elsif provider_type == 'Blu-ray Disc'
      		article_type = 'bluray'
  		elsif provider_type == 'DVD'
  	  		article_type = 'dvd'  	  					
    	end
    	article_type
  	end


end
