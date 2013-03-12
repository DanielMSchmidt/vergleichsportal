require 'mechanize'
require 'yaml'
class Buch_deSearch 

	def initialize(searchTerm, options={})
		@provider = YAML.load_file "config/buch_de.yml"
		@searchTerm = searchTerm
		@options = options
		@agent = Mechanize.new
	end

	def perform		
		links = getBookLinksFor(@searchTerm)
		links.take(@options[:count] || 5).collect{|link| getBookDataFor(link)}	
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
		book[:url] = link
		book
	end

	def getItem(page, query)
		page.search(query).text
	end
end