require 'rubygems'
require 'mechanize'

class EbaySearch

  def initialize
    @agent = Mechanize.new
  end

  def search_by_keywords(searchTerm, options={})
    links = self.getBookLinksFor(searchTerm, options)
    items = []
    links.take(options[:count] || 5).each{|link| items << getBookDataFor(link)}
    return items
  end

  def getNewestPriceFor(link)
    getBookDataFor(link)[:price]
  end

  def getBookLinksFor(searchTerm, options)
    #                 Suchbegriff                                      Neuwertig              Sofortkauf
    #                 |                                                |                      |             Deutsche Anbieter
    #                 |                                                |                      |             |
    search_options = "&_nkw=" + URI.escape(searchTerm).tr(' ', '+') + "&LH_ItemCondition=3" + "&LH_BIN=1" + "&LH_PrefLoc=1"
    page = @agent.get("http://www.ebay.de/sch/i.html?#{search_options}")

    return page.links_with(:class => "vip").collect{|link| link.href}
  end

  def getBookDataFor(url)
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
    return book
  end
end