require 'mechanize'
require 'yaml'

class BuchDeSearch

	def initialize()
		@provider = YAML.load_file "config/buecher_de.yml"
		@agent = Mechanize.new
	end

	def search_by_keywords(searchTerm, options={})
		if options.empty?
      		links = getBookLinksFor(searchTerm)
    	else
      		links = getAdvancedBookLinksFor(searchTerm, options)
    	end
    	
    	#is there a number of results?
    	if options[:count].nil?
      		links.collect{|link| getBookDataFor(link)}
    	else
      		links.take(options[:count]).collect{|link| getBookDataFor(link)}
    	end
	end

	def getNewestPriceFor(link)
    	Rails.logger.info "ThailaDeSearch#getNewestPriceFor called for #{link}"
    	getBookDataFor(link)[:price]
 	end

	def getBookLinksFor(searchTerm, options)
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

	def getItem(page, query)
		page.search(query).first.text
	end
end
