require 'spec_helper'

describe HomeController do

  let(:search_query) { FactoryGirl.create(:search_query) }
  let!(:provider) { FactoryGirl.create(:provider) }

  before(:each) do
    @merged_hash = [
      {name: "Testname",
       ean: 1234567891234,
       author: "Daniel",
       description: "Beispieldescription",
       urls: {1 => "www.google.de", 2 => "www.google.com"},
       prices: {1 => 12.9, 2 => 13.5},
       images: ["www.google.de/img.png", "www.google.com/img.png"]
       },
       {name: "Testname",
        ean: 1234567881234,
        author: "Daniel",
        description: "Beispieldescription",
        urls: {1 => "www.google.de", 2 => "www.google.com"},
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
      HomeController.stub(:searchAtProvider)
      HomeController.stub(:merge).and_return([])
      post 'search_results', search:{term: "Dan Brown"}
      response.should be_success
    end
    describe "searchAtProvider" do
      before(:each) do
        3.times do |n|
          #TODO: Refactor with factory girl
          Provider.create!(image_url: "www.google.com/image#{n}.png", name: "ebay#{n}", url: "www.ebay#{n}.de", active: true)
        end
      end

      it "should start a search for each provider" do
        HomeController.should_receive(:searchAtProvider).exactly(Provider.count).times
        HomeController.stub(:searchAtProvider)
        HomeController.stub(:merge).and_return([])
        HomeController.stub(:generateArticles)
        post 'search_results', search:{term: "Dan Brown"}
      end

      describe "merge of provider hashes" do
        before(:each) do
          @same_items_result = [
            [
              {
                :ean=>"1111111111111",
                :author=>"Dan Brown",
                :name=>"The Da Vinci Code",
                :description=>"Beispieldescription",
                :price=>9.65,
                :image => "www.google.de/image1.png",
                :url=>"www.google1.com"
              }
            ],[
              {
                :ean=>"1111111111111",
                :author=>"Dan Brown",
                :name=>"The Da Vinci Code",
                :description=>"Beispieldescription2",
                :price=>19.65,
                :image => "www.google.de/image2.png",
                :url=>"www.google2.com"
              }
            ]]

          @no_same_items_result = [
            [
              {
                :ean=>"2222222222222",
                :author=>"Dan Brown",
                :name=>"The Da Vinci Code",
                :description=>"Beispieldescription",
                :price=>9.65,
                :image => "www.google.de/image.png",
                :url=>"www.google1.com"
              }
            ],[
              {
                :ean=>"3333333333333",
                :author=>"Dan Brown",
                :name=>"The Da Vinci Code",
                :description=>"Beispieldescription2",
                :price=>19.65,
                :image => "www.google.de/image.png",
                :url=>"www.google2.com"
              }
            ]]
        end

        it "should return nothing if an empty array is given in" do
          HomeController.merge([]).should be_empty
          HomeController.merge([[],[]]).should be_empty
        end
        it "should return an array of right formatted hashes" do
          HomeController.merge(@no_same_items_result).each do |item|
            item.should have_key(:name)
            item.should have_key(:ean)
            item.should have_key(:author)
            item.should have_key(:description)
            item.should have_key(:urls)
            item.should have_key(:prices)
            item.should have_key(:images)
          end
        end

        describe "the returned array" do
          it "should be an equal sized array if all hashes have the same items" do
            expect(HomeController.merge(@same_items_result).count).to eq(@same_items_result.first.count)
          end

          it "should be an double sized array if the hashes diverge completely" do
            expect(HomeController.merge(@no_same_items_result).count).to eq(2 * @no_same_items_result.first.count)
          end

          describe "it should contain the merged prices of all provider" do
            describe "only one price available" do
              it "should be hashed with 1 => if it was in the first array" do
                HomeController.merge(@no_same_items_result).first[:prices].should have_key(1)
              end
              it "should be hashed with 2 => if it was in the second array" do
                HomeController.merge(@no_same_items_result).second[:prices].should have_key(2)
              end
            end
            describe "more than one price available" do
              it "should contain both in the right order" do
                expect(HomeController.merge(@same_items_result).first[:prices]).to eq({1 => 9.65, 2 => 19.65})
              end
            end
          end

          describe "it should contain the merged images of all provider" do
            describe "only one image available" do
              it "should be hashed with 1 => if it was in the first array" do
                HomeController.merge(@no_same_items_result).first[:images].should have_key(1)
              end
              it "should be hashed with 2 => if it was in the second array" do
                HomeController.merge(@no_same_items_result).second[:images].should have_key(2)
              end
            end
            describe "more than one image available" do
              it "should contain both in the right order" do
                expect(HomeController.merge(@same_items_result).first[:images]).to eq({1 => "www.google.de/image1.png", 2 => "www.google.de/image2.png"})
              end
            end
          end
        end
      end

      describe "should create articles" do
        describe "a search query wasnt found in the database" do
          before(:each) do
            SearchQuery.should_receive(:where).and_return([])
            HomeController.stub(:searchAtProvider)
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
          it "should add URLS" do
            expect{post 'search_results', search:{term: "Dan Brown"}}.to change{Url.count}.by(4)
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

  describe "#getAllNewestesPricesFor" do
    it "should do nothing if no articles are associated with the query" do
      HomeController.should_not_receive(:getTheNewestPriceFor)
      HomeController.getAllNewestesPricesFor(search_query)
    end

    describe "multiple items associated with article" do
      before(:each) do
        hash = {}
        Provider.all.collect{|x| x.id}.each do |provider_id|
          hash[provider_id] = provider_id
        end
        HomeController.stub(:getTheNewestPriceFor).and_return(hash)
        articles = []
        5.times do |n|
          articles << FactoryGirl.create(:article, id: n)
          FactoryGirl.create(:article_query_assignment, article_id: n)
        end
      end

      it "the searchquery should have the right amount of articles" do
        search_query.articles.count.should eq(5)
        HomeController.getAllNewestesPricesFor(search_query)
      end

      it "should add a new price for each article and provider" do
        expect{HomeController.getAllNewestesPricesFor(search_query)}.to change{Price.count}.by(Provider.count * search_query.articles.count)
      end

      it "should call #getTheNewestPriceFor for each article" do
        search_query.articles.each do |article|
          HomeController.should_receive(:getTheNewestPriceFor).with(article).once
        end
        HomeController.getAllNewestesPricesFor(search_query)
      end
    end
  end

  describe "#getTheNewestPriceFor" do
    before(:each) do
      @search = BuchDeSearch.new
      HomeController.should_receive(:getProviderInstance).exactly(Provider.count).times.and_return(@search)
      @search.stub(:getNewestPriceFor).and_return(3.14)
    end

    it "should call the getNewestPriceFor method on each Provider" do
      @search.should_receive(:getNewestPriceFor).exactly(Provider.count).times
      HomeController.getTheNewestPriceFor(search_query)
    end

    it "should call the getNewestPriceFor method with the url of the article" do
      search_query.articles.each do |article|
        article.urls.each{|url| search.should_receive(:getNewestPriceFor).with(url)}
      end
      HomeController.getTheNewestPriceFor(search_query)
    end

    it "should return a hash, which has each provider id as key and a decimal as value" do
      result = HomeController.getTheNewestPriceFor(search_query)
      Provider.all.collect{|x| x.id}.each do |provider_id|
        result.should have_key(provider_id)
        result[provider_id].should be_kind_of(Float)
      end
    end
  end

  describe "provider" do
    describe "ebay.de" do
      before(:each) do
        @search = EbaySearch.new
      end
      describe "search_by_keywords" do
        it "should respond to it" do
          @search.should respond_to(:search_by_keywords)
        end
        it "should return a right formatted value" do
          values = @search.search_by_keywords("Dan Brown")
          values.each do |value|
            value.should have_key(:name)
            value.should have_key(:ean)
            value.should have_key(:author)
            value.should have_key(:description)
            value.should have_key(:url)
            value.should have_key(:price)
            value.should have_key(:image)
          end
        end
      end
      describe "getNewestPriceFor" do
        it "should respond to it" do
          @search.should respond_to(:getNewestPriceFor)
        end
        it "should return a float" do
          #TODO: Sometimes passes sometimes not (fix it with a loop e.g.)
          @search.getNewestPriceFor("http://www.ebay.de/itm/DAN-BROWN-Meteor-NEU-KEIN-PORTO-/290263996355?pt=Belletristik&hash=item43951517c3").should eq(9.99)
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
