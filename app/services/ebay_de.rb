require 'rubygems'
require 'mechanize'

class EbaySearch

  def initialize
    @agent = Mechanize.new
  end

  def search_by_keywords(searchTerm, options={})
    links = self.getBookLinksFor(searchTerm, options)
    links.take(options[:count] || 5).collect{|link| getBookDataFor(link)}
  end

  page = @agent.get('http://www.ebay.de/sch/ebayadvsearch/?rt=nc/')
  book = {}
  books = []
  ebay_form = page.form('adv_search_from')
  ebay_form._nkw = 'dan brown'

  ebay_form.checkbox_with(name: 'LH_BIN').check
  page = @agent.submit(ebay_form, ebay_form.buttons.first)
  link = page.uri.to_s  + "&LH_ItemCondition=3"

  page = @agent.get(link)

  book_links = page.links_with(:class => "vip").collect{|link| link.href}


  def self.get_book_data_for(url)
    page = @agent.get(url)

    details_array = []
    page.search("table.vi-ia-attrGroup").search('td, th').each{|item| details_array << item.text}

    details_array << " " if details_array.count.odd?
    details = Hash[*details_array]

    normal_price = page.search(".vi-is1-prcp").text[/\d*(,|\.)\d{2}$/].tr(',', '.').to_f unless page.search(".vi-is1-prcp").text[/\d*(,|\.)\d{2}$/].nil?
    unless page.search(".vi-is1-sh-srvcCost").text[/\d*(,|\.)\d{2}$/].nil?
      shipping_price = page.search(".vi-is1-sh-srvcCost").text[/\d*(,|\.)\d{2}$/].tr(',', '.').to_f
    else
      shipping_price = 0
    end


    book[:ean] = details["EAN: "] ||= details["ISBN-13: "] ||= details["ISBN: "]
    book[:author] = details["Autor: "]
    book[:name] = details["Titel: "]
    book[:price] = normal_price + shipping_price

    puts book
  end
end
