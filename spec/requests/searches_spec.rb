require 'rake'
require 'spec_helper'

describe "Searches" do
  before(:all) do
    #TODO: Use rake task instead
    Provider.all.each{|x| x.delete}
    Provider.create!(name: 'Ebay',
                     url: 'www.ebay.de',
                     image_url: 'http://pics.ebaystatic.com/aw/pics/announcements/new/logo/logo-fixed-cropped.png',
                     active: true)
    Provider.create!(name: 'BuchDe',
                     url: 'www.buch.de',
                     image_url: 'http://www.gruenderszene.de/datenbank/uploads/company_normal/buch-de.jpg',
                     active: true)

    @ebay_search_results = [
                         {
                           :ean=>"1111111111111",
                           :author=>"Dan Brown",
                           :name=>"The Da Vinci Code",
                           :description=>"Beispieldescription",
                           :price=>9.65,
                           :image => "www.google.de/image1.png",
                           :url=>"www.google1.com"
                         },
                         {
                           :ean=>"1111111111112",
                           :author=>"Dan Brown",
                           :name=>"Inferno",
                           :description=>"Beispieldescription2",
                           :price=>19.65,
                           :image => "www.google.de/image3.png",
                           :url=>"www.google4.com"
                            }
                          ]

    @buch_de_search_results = [
                         {
                           :ean=>"1111111111111",
                           :author=>"Dan Brown",
                           :name=>"The Da Vinci Code",
                           :description=>"Beispieldescription",
                           :price=>9.65,
                           :image => "www.google.de/image1.png",
                           :url=>"www.google1.com"
                         },
                         {
                           :ean=>"1111111111113",
                           :author=>"Dan Brown",
                           :name=>"Sakrileg",
                           :description=>"Beispieldescription2",
                           :price=>19.65,
                           :image => "www.google.de/image3.png",
                           :url=>"www.google4.com"
                         }
                         ]
  end

  it "should have the providers in the database" do
    Provider.count.should eq(2)
  end

  describe "a search without using the real providers" do
    before(:each) do
      EbaySearch.stub(:searchByKeywords).and_return(@ebay_search_results)
      BuchDeSearch.stub(:searchByKeywords).and_return(@buch_de_search_results)
    end

    it "should be able to start a search", slow: true do
      visit root_path
      fill_in 'search[term]', with: 'Dan Brown'
      click_on 'Finden!'
      page.should have_content('Dan Brown')
      page.should have_content('Inferno')
    end

  end
  describe "a search with the real providers" do
    it "should be able to start a search", slow: true do
      visit root_path
      fill_in 'search[term]', with: 'Dan Brown'
      click_on 'Finden!'
      page.should have_content('Dan Brown')
      page.should have_content('Inferno')
    end
  end
end

