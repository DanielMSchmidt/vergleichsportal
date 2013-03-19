require 'mechanize'
require 'yaml'

class ThailaDeSearch

	def initialize()
		@provider = YAML.load_file "config/thaila_de.yml"
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

	def getBookLinksFor(searchTerm)
		page = @agent.get(@provider[:url])

		buch_form = page.form(@provider[:search_form])

		buch_form[@provider[:search_field]] = searchTerm

		page = @agent.submit(buch_form, buch_form.buttons.first)
		books = page.links_with(:href => @provider[:link_href]).collect{|link| link.href}.uniq
	end

	def getNewestPriceFor(link)
    	Rails.logger.info "ThailaDeSearch#getNewestPriceFor called for #{link}"
    	getBookDataFor(link)[:price]
 	end

	def getBookDataFor(link)
		page = @agent.get(link)
		book = {}
		@provider[:book].each do |key, value|
			book[key] = getItem(page,value)
		end
		book[:price] = page.search(@provider[:price]).text[/\d+,\d+/].tr(',','.').to_f
		book[:url] = link
		details_headlines = page.search(@provider[:detail_headline])
		details_values = page.search(@provider[:detail_value])
		position = details_headlines.collect{|value| value.text}.index("EAN:")
		book[:ean] = details_values[position] if position
		book
	end

	def getAdvancedBookLinksFor(searchTerm, options)
    	title =  ((options[:title].nil?) ? '' : options[:title]) 
    	author = ((options[:author].nil?) ? '' : options[:author])
    	page = @agent.get('http://www.thalia.de/shop/tha_homestartseite/suche/?fi=&st='+title+'&sa='+author)
    	#st: titel   sa:  autor 
   		page.links_with(:class => @provider[:link_class]).collect{|link| link.href}
  	end

	def getItem(page, query)
		page.search(query).last.text
	end
end
