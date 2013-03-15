require 'mechanize'
require 'yaml'

class BuchDeSearch

  def initialize()
    @provider = YAML.load_file "config/buch_de.yml"
    @agent = Mechanize.new
  end

  def searchByKeywords(searchTerm, options={})
    links = getBookLinksFor(searchTerm, options)
    links.take(options[:count] || 5).collect{|link| getBookDataFor(link)}
  end

  def getNewestPriceFor(link)
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
    book[:url] = link
    book[:image] = page.images.first
    book[:price] = book[:price].tr(',','.').to_f

    book
  end

  def getItem(page, query)
    page.search(query).text
  end
end
