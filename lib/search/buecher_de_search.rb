require 'mechanize'
require 'yaml'

class BuchDeSearch

	def initialize()
		@provider = YAML.load_file "config/buecher_de.yml"
		@agent = Mechanize.new
	end

	def search_by_keywords(searchTerm, options={})
		links = getBookLinksFor(searchTerm, options)
		links.take(options[:count] || 5).collect{|link| getBookDataFor(link)}
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

	def getItem(page, query)
		page.search(query).first.text
	end
end
