#encoding: utf-8
require 'mechanize'
require 'yaml'

class ThaliaDeSearch

	def initialize()
		@provider = YAML.load_file "config/thalia_de.yml"
		@agent = Mechanize.new
	end

	def searchByKeywords(searchTerm, options={})

		if options.empty?
      		links = getArticleLinksFor(searchTerm)
    	else
      		links = getAdvancedArticleLinksFor(searchTerm, options)
    	end

    	#is there a number of results?
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
		articles = page.links_with(:href => @provider[:link_href]).collect{|link| link.href}.uniq
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
		article[:price] = page.search(@provider[:price]).text[/\d+,\d+/].tr(',','.').to_f
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
   		page.links_with(:class => @provider[:link_class]).collect{|link| link.href}
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
		page.search(query).last.text
	end

	def getType(page)
    	type = page.search('.itemSubcategory').text.strip
    	if type == 'Hörbuch' || type == 'Musik'
      		type = 'cd'
    	elsif type == 'Film'
      		type = 'dvd'
      	elsif type == 'Blu-ray'
      		type = 'bluray'
      	elsif type == 'eBook'
      		type = 'ebook'
      	elsif type == 'Buch'
      		type = 'book'
    	end    		
    	type
  	end
end
