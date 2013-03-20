require 'rubygems'
require 'mechanize'

class EbaySearch
  #TODO: Add option support

  def initialize
    @agent = Mechanize.new
  end

  def searchByKeywords(searchTerm, options={})
    Rails.logger.info "EbaySearch#searchByKeywords called for #{searchTerm} with #{options}"
    options.delete(:article_type)
    if options.empty?
      links = self.getArticleLinksFor(searchTerm)
    else
      links = getAdvancedArticleLinksFor(searchTerm, options) #MAYBE you need an 'self.'
    end
        
    items = []
    #is there a max number of results?
      if options[:count].nil?
        links.each{|link| items << getBookDataFor(link)}
      else
        links.take(options[:count]).each{|link| items << getBookDataFor(link)}
      end
    return items
  end

  def getNewestPriceFor(link)
    Rails.logger.info "EbaySearch#getNewestPriceFor called for #{link}"
    getBookDataFor(link)[:price]
  end

  def getArticleLinksFor(searchTerm)
    Rails.logger.info "EbaySearch#getArticleLinksFor called for #{searchTerm} with #{options}"

    #                 Suchbegriff                                      Neuwertig              Sofortkauf
    #                 |                                                |                      |             Deutsche Anbieter
    #                 |                                                |                      |             |
    search_options = "&_nkw=" + URI.escape(searchTerm).tr(' ', '+') + "&LH_ItemCondition=3" + "&LH_BIN=1" + "&LH_PrefLoc=1"
    page = @agent.get("http://www.ebay.de/sch/i.html?#{search_options}")

    return page.links_with(:class => "vip").collect{|link| link.href}
  end

  def getAdvancedArticleLinksFor(searchTerm, options)
    #The results get filtered later in search.rb
    Rails.logger.info "EbaySearch#getAdvancedArticleLinksFor called for #{searchTerm} with #{options}"
    title =  ((options[:title].nil?) ? '' : options[:title]) 
    author = ((options[:author].nil?) ? '' : options[:author])

    searchTerm = title+' '+author
    #                 Suchbegriff                                      Neuwertig              Sofortkauf
    #                 |                                                |                      |             Deutsche Anbieter
    #                 |                                                |                      |             |
    search_options = "&_nkw=" + URI.escape(searchTerm).tr(' ', '+') + "&LH_ItemCondition=3" + "&LH_BIN=1" + "&LH_PrefLoc=1"
    page = @agent.get("http://www.ebay.de/sch/i.html?#{search_options}")

    return page.links_with(:class => "vip").collect{|link| link.href}
  end

  def getBookDataFor(url)
    Rails.logger.info "EbaySearch#getBookDataFor called for #{url}"
    book = {}
    page = @agent.get(url)

    details_array = []
    page.search("table.vi-ia-attrGroup").search('td, th').each{|item| details_array << item.text}

    details_array << " " if details_array.count.odd?
    details = Hash[*details_array]

    normal_price = page.search(".vi-is1-prcp").text[/\d*(,|\.)\d{2}$/].tr(',', '.').to_f unless page.search(".vi-is1-prcp").text[/\d*(,|\.)\d{2}$/].nil?
    shipping = page.search(".vi-is1-sh-srvcCost").text[/\d*(,|\.)\d{2}$/]

    unless shipping.nil?
      shipping_price = shipping.tr(',', '.').to_f
    else
      shipping_price = 0
    end

    book[:ean] = details["EAN: "] ||= details["ISBN-13: "] ||= details["ISBN: "]
    book[:author] = details["Autor: "]
    book[:name] = details["Titel: "]
    book[:price] = (shipping_price || 0) + (normal_price || 0)
    book[:image] = nil
    book[:description] = nil
    book[:url] = url
    #book[:type] = details["Format: "]

    Rails.logger.info "EbaySearch#getBookDataFor called for #{url} returns #{book}"
    return book
  end
end