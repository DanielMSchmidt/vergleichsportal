require 'rubygems'
require 'httparty'
require 'uri'

class Ebay
  include HTTParty

  #Takes the Keywords as String
  def self.getItemByKeyword(keywords, options={})
    parameter = {
      "OPERATION-NAME" => "findItemsByKeywords",
      "SERVICE-VERSION" => "1.0.0",
      "SECURITY-APPNAME" => app_id,
      "RESPONSE-DATA-FORMAT" => "JSON",
      "keywords" => URI.escape(keywords).tr(' ', '&'),
      "REST-PAYLOAD" => nil,
      "itemFilter(0).name" => "ListingType",
      "itemFilter(0).value" => "FixedPrice"

    }

    response = JSON.parse(HTTParty.get("#{api_url}#{hash_to_url_params(parameter)}"))
    items = []

    response["findItemsByKeywordsResponse"].first["searchResult"].first["item"].each do |item|

      result = {
          name: item["title"],
        ean: "",
        author: "",
        description: "",
        price: ""
      }
      items << result
    end
  end

  def self.hash_to_url_params(hash)
    hash.to_a.collect do |x|
      if x[1].nil?
        x[0]
      else
        x.join("=")
      end
    end.join("&")
  end

  private

  def self.api_url
    "http://svcs.ebay.com/services/search/FindingService/v1?"
  end

  def self.app_id
    "DanielSc-bedc-436b-9c85-8fbee41ec25c"
  end
end

Ebay.getItemByKeyword "Dan Brown"