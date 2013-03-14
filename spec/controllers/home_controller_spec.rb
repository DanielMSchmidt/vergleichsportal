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
