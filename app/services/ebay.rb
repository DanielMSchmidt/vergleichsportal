require 'rubygems'
require 'httparty'

class Ebay
  include HTTParty

  def self.getEbayOfficialTime
    format :xml

    headers(ebay_headers.merge({"X-EBAY-API-CALL-NAME" => "GeteBayOfficialTime"}))

    requestXml = "<?xml version='1.0' encoding='utf-8'?>
                  <GeteBayOfficialTimeRequest xmlns=\"urn:ebay:apis:eBLBaseComponents\">
                    <RequesterCredentials>
                      <eBayAuthToken>#{auth_token}</eBayAuthToken>
                    </RequesterCredentials>
                  </GeteBayOfficialTimeRequest>"

    response = post(api_url, :body => requestXml)
    raise "Bad Response | #{response.inspect}" if response.parsed_response['GeteBayOfficialTimeResponse']['Ack'] != 'Success'
    response.parsed_response['GeteBayOfficialTimeResponse']['Timestamp']
  end

  def self.getItemByKeywords
    format :xml

    headers(ebay_headers.merge({"X-EBAY-SOA-GLOBAL-ID" => " EBAY-DE", "X-EBAY-SOA-OPERATION-NAME" => "findItemsByKeywords"}))

    requestXml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>
    <findItemsByKeywordsRequest xmlns=\"http://www.ebay.com/marketplace/search/v1/services\">
      <keywords> Dan Brown </keywords>
      <outputSelector> PictureURLSuperSize </outputSelector>
      <outputSelector> AspectHistogram </outputSelector>
    </findItemsByKeywordsRequest>"


    response = post(api_url, :body => requestXml)
    puts response
    raise "Bad Response | #{response.inspect}" if response.parsed_response['GeteBayOfficialTimeResponse']['Ack'] != 'Success'
    response.parsed_response['GeteBayOfficialTimeResponse']['Timestamp']
  end

  private

  def self.ebay_headers
    {"X-EBAY-API-COMPATIBILITY-LEVEL" => "433",
               "X-EBAY-API-DEV-NAME" => 'b8e0a265-42d8-467e-a327-677645b61a2f',
               "X-EBAY-API-APP-NAME" => 'DanielSc-9c33-40ed-bcc1-f5d3377decf7',
               "X-EBAY-SOA-SECURITY-APPNAME" => "DanielSc-9c33-40ed-bcc1-f5d3377decf7",
               "X-EBAY-API-CERT-NAME" => 'd10f73bf-3664-4ce0-a851-033709e423bf',
               "X-EBAY-API-SITEID" => "0",
               "Content-Type" => "text/xml"}
  end

  def self.auth_token
    "AgAAAA**AQAAAA**aAAAAA**Uzs/UQ**nY+sHZ2PrBmdj6wVnY+sEZ2PrA2dj6wFk4GhCpCLpwudj6x9nY+seQ**bRoCAA**AAMAAA**JTMQiXBqKQgb5FSLOmrkdsx98OwHzZzb4NIRfgUlB3dGfdufkC1VKlpI12e4nXWIV1Cy8Df1UOGUe2P9gvcDDKh4isGMPG96cyLC0M10bM7CsMuSyyl6ZkxwNrgqOOWMACPP1ITRxDy+15nXe5XAfPJatLaXh+wdKQGapvf3xsLiwfObTOGyhmCizBIoGv7jgHMsU23Mk6liAPymh0uaa6fu3ufJlD4dE4rgm1aTtYuw0s3ZHiYckqIYk8tkDerEdGIkTmWnjg7TaNqtIjXYFTv/LjhSh1qdfdOXvhhY5yqV960wytfY6p8iTfdGBK89YgS6sgEU070YdcquTHtlIW7ae6FLcGHQZtIGiNfKvNL9deuPKi3RNmintmbKPcZhcYQbRNaw8/LTu7AzMCogsRwVrXt6/Pxx4MFyIGjvYBBM8P2bnUt+2t36W3EkJhyN0XIespRaAE8vDjyXhtrkP8bGGGMEnwXOWKB+b4MqU95OYgq0Jvk+nUwW9FQqBM2SwHtt9a4+/CbdiwJaC/WkQmGyFqEV7KdHUQSpzQurbK+eJ2Zw/myQsOmnJ3AjgPm5nh5Y2J1ZrgGjsIP1W5lGjYk84wcAPwHeJsjdoXriMbGxJrvre0zxSClU83TklHXEDiSoki8nFGhEq2WNKoxQUD7F+XgA7ZGnVDHuevfuhbY+zzstCjhD7T/mCck2kooZi2oVQ6q/HiDeE7mwUADgLxvu0qZDmEmxdN8GlGarPko5HFn2zvwZ7xgcfbT/YAt2"
  end

  def self.api_url
    "https://api.sandbox.ebay.com/ws/api.dll"
  end
end

puts Ebay.getEbayOfficialTime
puts Ebay.getItemByKeywords