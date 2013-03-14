require 'spec_helper'

describe HomeController do

  before(:each) do
    @merged_hash = [
      {name: "Testname",
       ean: 1234567891234,
       author: "Daniel",
       description: "Beispieldescription",
       url: {1 => "www.google.de", 2 => "www.google.com"},
       prices: {1 => 12.9, 2 => 13.5},
       images: ["www.google.de/img.png", "www.google.com/img.png"]
       },
       {name: "Testname",
        ean: 1234567881234,
        author: "Daniel",
        description: "Beispieldescription",
        url: {1 => "www.google.de", 2 => "www.google.com"},
        prices: {1 => 12.9, 2 => 13.5},
        images: ["www.google.de/img.png", "www.google.com/img.png"]
        }
      ]
  end
  let(:search_query) { FactoryGirl.create(:search_query) }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "POST 'search_results'" do
    it "returns http success" do
      post 'search_results', search:{term: "Dan Brown"}
      HomeController.stub(:search)
      HomeController.stub(:merge).and_return([])
      response.should be_success
    end
    describe "search" do
      before(:each) do
        3.times do |n|
          Provider.create!(image_url: "www.google.com/image#{n}.png", name: "ebay#{n}", url: "www.ebay#{n}.de")
        end
      end

      it "should start a search for each provider" do
        HomeController.should_receive(:search).exactly(Provider.count).times
        HomeController.stub(:search)
        HomeController.stub(:merge).and_return([])
        HomeController.stub(:generateArticles)
        post 'search_results', search:{term: "Dan Brown"}
      end

      describe "merge of provider hashes" do
        it "should return nothing if an empty array is given in" do
          HomeController.merge([]).should be_empty
        end
        it "should return an array of right formatted hashes" do
          search_results = [] #To be filled
          HomeController.merge(search_results).each do |item|
            item.should have_key(:name)
            item.should have_key(:ean)
            item.should have_key(:author)
            item.should have_key(:description)
            item.should have_key(:url)
            item.should have_key(:prices)
            item.should have_key(:images)
          end
        end

        describe "the returned array" do
          it "should be an equal sized array if all hashes have the same items" do
            same_items_result = [] #To be filled
            HomeController.merge(same_items_result).count.should equal(same_items_result.count)
          end

          it "should be an double sized array if the hashes diverge completely" do
            no_same_items_result = [] #To be filled
            HomeController.merge(no_same_items_result).count.should equal(2 * no_same_items_result.count)
          end

          it "should contain the merged prices of all provider"
          it "should contain the merged images of all provider"
        end
      end

      describe "should create articles" do
        describe "a search query wasnt found in the database" do
          before(:each) do
            SearchQuery.should_receive(:where).and_return([])
            HomeController.stub(:search)
            HomeController.should_receive(:merge).and_return(@merged_hash)
          end
          it "should add a searchQuery" do
            expect{post 'search_results', search:{term: "Dan Brown"}}.to change{SearchQuery.count}.by(1)
          end
          it "should add articles" do
            expect{post 'search_results', search:{term: "Dan Brown"}}.to change{Article.count}.by(2)
          end
          it "should add images" do
            expect{post 'search_results', search:{term: "Dan Brown"}}.to change{Image.count}.by(4)
          end
          it "should add prices" do
            expect{post 'search_results', search:{term: "Dan Brown"}}.to change{Price.count}.by(4)
          end

        end
        describe "if a search query was found in the database" do
          it "shouldnt add an article" do
            SearchQuery.should_receive(:where).and_return([search_query])
            HomeController.stub(:search)
            expect{post 'search_results', search:{term: "Dan Brown"}}.to change{Article.count}.by(0)
          end
          it "should add a searchquery" do
            SearchQuery.should_receive(:where).and_return([search_query])
            HomeController.stub(:search)
            expect{post 'search_results', search:{term: "Dan Brown"}}.to change{SearchQuery.count}.by(1)
          end
        end
      end
    end
  end

  describe "GET 'admin'" do
    it "returns http success" do
      get 'admin'
      response.should be_success
    end
  end

end
