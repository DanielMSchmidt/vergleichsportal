require 'mechanize'
require 'yaml'

class BuchDeSearch
  #TODO add option support

  def initialize()
    @provider = YAML.load_file "config/buch_de.yml"
    @agent = Mechanize.new
    
  end

  def searchByKeywords(searchTerm, options={})
    Rails.logger.info "BuchDeSearch#searchByKeywords called for #{searchTerm} with #{options}"
    
    if options.empty?
      links = getBookLinksFor(searchTerm)
    else
      links = getAdvancedBookLinksFor(searchTerm, options)
    end

    #is there a number of results?
    if options[:count].nil?
      books = links.collect{|link| getBookDataFor(link)}
    else
      books =links.take(options[:count]).collect{|link| getBookDataFor(link)}
    end


  end

  def getNewestPriceFor(link)
    Rails.logger.info "BuchDeSearch#getNewestPriceFor called for #{link}"
    getBookDataFor(link)[:price]
  end


  def getBookLinksFor(searchTerm, options)
    Rails.logger.info "BuchDeSearch#getBookLinksFor called for #{searchTerm} with #{options}"
    page = @agent.get(@provider[:url])

    buch_form = page.form(@provider[:search_form])

    buch_form[@provider[:search_field]] = searchTerm

    page = @agent.submit(buch_form, buch_form.buttons.first)
    
    page.links_with(:class => @provider[:link_class]).collect{|link| link.href}
  end

  def getAdvancedBookLinksFor(searchTerm, options)
    title =  ((options[:title].nil?) ? '' : options[:title]) 
    author = ((options[:author].nil?) ? '' : options[:author])
    page = @agent.get('http://www.buch.de/shop/home/suche/?fi=&st='+title+'&sa='+author)
    #st: titel   sa:  autor 
    page.links_with(:class => @provider[:link_class]).collect{|link| link.href}
  end

  def getBookDataFor(link)
    Rails.logger.info "BuchDeSearch#getBookDataFor called for #{link}"
    page = @agent.get(link)
    book = {}
    @provider[:book].each do |key, value|
      book[key] = getItem(page,value)
    end
    book[:url] = link
    book[:image] = page.images.first #TODO: Returns a Mechanize object which can't be handled (url instead plz)
    book[:price] = book[:price].tr(',','.').to_f

    Rails.logger.info "BuchDeSearch#getBookDataFor called for #{link} returns #{book}"
    book
  end

  def getItem(page, query)
    page.search(query).text
  end
end
