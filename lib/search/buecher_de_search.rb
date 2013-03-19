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
      		links = getBookLinksFor(searchTerm)
    	else
      		links = getAdvancedBookLinksFor(searchTerm, options)
    	end
    	
    	#is there a number of results?
    	if options[:count].nil?
      		articles = links.collect{|link| getBookDataFor(link)}
    	else
      		articles = links.take(options[:count]).collect{|link| getBookDataFor(link)}
    	end

    	filterByType(articles, options)
	end

	def getNewestPriceFor(link)
    	#Rails.logger.info "ThailaDeSearch#getNewestPriceFor called for #{link}"
    	getBookDataFor(link)[:price]
 	end

	def getBookLinksFor(searchTerm)
		page = @agent.get(@provider[:url])

		buch_form = page.form(@provider[:search_form])

		buch_form[@provider[:search_field]] = searchTerm

		page = @agent.submit(buch_form, buch_form.buttons.first)
		books = page.links_with(:class => @provider[:link_class]).collect{|link| link.href}
	end

	def getBookDataFor(link)
		page = @agent.get(link)
		book = {}
		@provider[:book].each do |key, value|
			book[key] = getItem(page,value)
		end
		page.search(@provider[:produktinfo]).each do |value|
			value_array = value.text.split(": ")
			book[:ean] =  value_array[1] if value_array[0] == 'ISBN-13'
		end
		books[:price] = page.search(@provider[:price]).to_s[/\d+,\d+/].tr(',','.').to_f
		books[:image_url] = page.images.at(5)
		book[:url] = link
		book[:type] = getType(page)
		book
	end

	def getAdvancedBookLinksFor(searchTerm, options)
		page = agent.get('http://www.buecher.de/go/search_search/expert_search/lfa/quicksearchform/')
		buch_form = page.form(:action => 'http://www.buecher.de/go/search_search/expert_search_result/receiver_object/shop_search_expertsearch/')
		buch_form['form[personen]'] =  ((options[:author].nil?) ? '' : options[:author])
		buch_form['form[schlagworte]'] = ((options[:title].nil?) ? '' : options[:title])
		page = agent.submit(buch_form, buch_form.buttons.first)
		books=  page.links_with(:class => "booklink").collect{|link| link.href}
	end

  	def filterByType(articles, options)
    	if options[:type].nil?
    		filteredArticles = articles
    	else
    		articles.each do |element|
        		if element.type == options[:type]
          			filteredArticles = element
        		end
    		end
    	end
    filteredArticles
 	end

	def getItem(page, query)
		page.search(query).first.text
	end

	def getType(page)
    type = page.search('.pm_artikeltyp').first.text
    if type == 'Audio CD'
      type = 'cd'
    elsif type == 'eBook, ePUB'
      type = 'ebook'
    elsif type == 'Gebundenes Buch' || type == 'Broschiertes Buch'
      type = 'book'
    elsif type == 'Blu-ray Disc'
      type = 'bluray'
  	elsif type == 'DVD'
  	  type = 'dvd'	
    end
    type
  end


end
