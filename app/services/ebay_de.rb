require 'rubygems'
require 'mechanize'

agent = Mechanize.new
page = agent.get('http://www.ebay.de/sch/ebayadvsearch/?rt=nc/')
book = {}
ebay_form = page.form('adv_search_from')
ebay_form._nkw = 'dan brown'

ebay_form.checkbox_with(name: 'LH_BIN').check
page = agent.submit(ebay_form, ebay_form.buttons.first)
link = page.uri.to_s  + "&LH_ItemCondition=3"


page = agent.get(link)
#pp page
book_links = page.links_with(:class => "vip").collect{|link| link.href}

page = agent.get(book_links.first)

page.search("table.vi-ia-attrGroup").search('.vi-ia-attrColPadding').each do |item|
  book[:ean] ||= item.text if item.text.length == 13 && item.text.to_i != 0
end

array = []
puts page.search("table.vi-ia-attrGroup").search('td, th').each{|item| array << item.text}

puts "Array: #{array}"



puts book