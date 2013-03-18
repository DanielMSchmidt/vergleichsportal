require 'spec_helper'

describe HomeController do

  let!(:search_query) { FactoryGirl.create(:search_query) }
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

      @search = Search.new(search_query.value)
      Search.stub(:new).and_return(@search)
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
      @search.stub(:searchAtProvider)
      @search.stub(:merge).and_return([])
      post 'search_results', search:{term: "Dan Brown"}
      response.should be_success
    end
    describe "searchAtProvider" do
      before(:each) do
        Provider.all.each{|x| x.delete}
        3.times do |n|
          #TODO: Refactor with factory girl
          Provider.create!(image_url: "www.google.com/image#{n}.png", name: "ebay#{n}", url: "www.ebay#{n}.de", active: true)
        end
      end

      it "should start a search for each provider" do
        @search.should_receive(:searchAtProvider).exactly(Provider.count).times
        @search.stub(:searchAtProvider)
        @search.stub(:merge).and_return([])
        @search.stub(:generateArticles)
        SearchQuery.all.each{|x| x.delete}
        post 'search_results', search:{term: "Dan Brown"}
      end

      describe "#filter" do
        it "should delete all results which have a ean with nil" do
          articles = [{:ean=>nil, :author=>nil, :name=>nil, :price=>0, :image=>nil, :description=>nil, :url=>"http://www.ebay.de/itm/a796"}, {:ean=>1234567912345, :author=>nil, :name=>nil, :price=>0, :image=>nil, :description=>nil, :url=>"http://www.ebay.de/itm/Illuminatiik&hash=item53f62d4780"}]
          expect(@search.filterEmptyArticles(articles)).to eq([{:ean=>1234567912345, :author=>nil, :name=>nil, :price=>0, :image=>nil, :description=>nil, :url=>"http://www.ebay.de/itm/Illuminatiik&hash=item53f62d4780"}])
        end
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
          @search.merge([]).should be_empty
          @search.merge([[],[]]).should be_empty
        end
        it "should return an array of right formatted hashes" do
          @search.merge(@no_same_items_result).each do |item|
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
            expect(@search.merge(@same_items_result).count).to eq(@same_items_result.first.count)
          end

          it "should be an double sized array if the hashes diverge completely" do
            expect(@search.merge(@no_same_items_result).count).to eq(2 * @no_same_items_result.first.count)
          end

          describe "it should contain the merged prices of all provider" do
            describe "only one price available" do
              it "should be hashed with 1 => if it was in the first array" do
                @search.merge(@no_same_items_result).first[:prices].should have_key(1)
              end
              it "should be hashed with 2 => if it was in the second array" do
                @search.merge(@no_same_items_result).second[:prices].should have_key(2)
              end
            end
            describe "more than one price available" do
              it "should contain both in the right order" do
                expect(@search.merge(@same_items_result).first[:prices]).to eq({1 => 9.65, 2 => 19.65})
              end
            end
          end

          describe "it should contain the merged images of all provider" do
            describe "only one image available" do
              it "should be hashed with 1 => if it was in the first array" do
                @search.merge(@no_same_items_result).first[:images].should have_key(1)
              end
              it "should be hashed with 2 => if it was in the second array" do
                @search.merge(@no_same_items_result).second[:images].should have_key(2)
              end
            end
            describe "more than one image available" do
              it "should contain both in the right order" do
                expect(@search.merge(@same_items_result).first[:images]).to eq({1 => "www.google.de/image1.png", 2 => "www.google.de/image2.png"})
              end
            end
          end
        end
      end

      describe "should create articles" do
        describe "a search query wasnt found in the database" do
          before(:each) do
            SearchQuery.should_receive(:where).and_return([])
            @search.stub(:searchAtProvider)
            @search.should_receive(:merge).and_return(@merged_hash)
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
            @search.stub(:search)
            expect{post 'search_results', search:{term: "Dan Brown"}}.to change{Article.count}.by(0)
          end
          it "should add a searchquery" do
            SearchQuery.should_receive(:where).and_return([search_query])
            @search.stub(:search)
            expect{post 'search_results', search:{term: "Dan Brown"}}.to change{SearchQuery.count}.by(1)
          end
        end
      end
    end
  end

  describe "#find" do
    it "should do nothing if no articles are associated with the query" do
      @search.should_not_receive(:getNewestPriceFor)
      @search.find
    end
  end

  describe "#getAllNewestesPrices" do
    before(:each) do
      @searcher = Search.new(search_query.value)
      @searching = BuchDeSearch.new
      @searching.stub(:getNewestPriceFor).and_return(3.14)

      query = SearchQuery.create(value: search_query.value)
      query.articles.create(name: "TEST", ean: "1234567890123", description: "Demodescription", author: "Testauthor")
      SearchQuery.stub(:where).and_return([query])

    end


    it "should be articles accociated with the search query" do
      query = SearchQuery.where(value: search_query.value).first
      query.should_not be_nil
      query.articles.first.should_not be_nil
    end

    it "should call the getNewestPriceFor method on each Provider" do
      @searcher.should_receive(:getProviderInstance).exactly(Provider.count).times.and_return(@searching)
      @searching.should_receive(:getNewestPriceFor).exactly(Provider.count).times

      @searcher.getAllNewestesPrices
    end

    it "should call the getNewestPriceFor method with the url of the article" do
      @searcher.should_receive(:getProviderInstance).exactly(Provider.count).times.and_return(@searching)
      search_query.articles.each do |article|
        article.urls.each{|url| search.should_receive(:getNewestPriceFor).with(url)}
      end

      @searcher.getAllNewestesPrices
    end
  end

  describe "provider" do
    describe "ebay.de" do
      before(:each) do
        @searching = EbaySearch.new
      end
      describe "search_by_keywords" do
        it "should respond to it", slow: true do
          @searching.should respond_to(:searchByKeywords)
        end
        it "should return a right formatted value", slow: true do
          values = @searching.searchByKeywords("Dan Brown")
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
        it "should respond to it", slow: true do
          @searching.should respond_to(:getNewestPriceFor)
        end
        it "should return a float", slow: true do
          #TODO: Sometimes passes sometimes not (fix it with a loop e.g.)
          @searching.getNewestPriceFor("http://www.ebay.de/itm/DAN-BROWN-Meteor-NEU-KEIN-PORTO-/290263996355?pt=Belletristik&hash=item43951517c3").should eq(9.99)
        end
      end
    end

    describe "buch.de" do
      before(:each) do
          @searching = BuchDeSearch.new
      end
      describe "search_by_keywords" do
        it "should respond to it", slow: true do
          @searching.should respond_to(:searchByKeywords)
        end
        it "should return a right formatted value", slow: true do
          values = @searching.searchByKeywords("Dan Brown")
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
        it "should respond to it", slow: true do
          @searching.should respond_to(:getNewestPriceFor)
        end
        it "should return a float", slow: true do
          @searching.getNewestPriceFor("http://www.buch.de/de.buch.shop/shop/1/home/rubrikartikel/inferno/dan_brown/ISBN3-7857-2480-2/ID34201026.html;jsessionid=.tc1p?tfs=yia%2FnwD%2F%2F%2F%2F%2FAAAAAA%3D%3D&inredirect=1").should eq(26)
        end
      end
    end
  end

  describe "filter search results" do
    before(:each) do
      @article = Article.first
      @result = [@article]
      @search = Search.new(search_query.value)
      Search.stub(:new).and_return(@search)
      @search.stub(:find).and_return(@result)
    end
    it "should display the results which are from active providers" do

      @article.should_receive(:available_for).at_most(Provider.count).times.and_return(true)
      expect{post 'search_results', search:{term: "Dan Brown"}}.to change{@result.count}.by(0)
    end
    it "shouldnt display the results which are from inactive providers" do
      @article.should_receive(:available_for).at_most(Provider.count).times.and_return(false)
      expect{post 'search_results', search:{term: "Dan Brown"}}.to change{@result.count}.by(-1)
    end
  end

  describe "active user" do
    describe "not logged in" do
      it "should have a user which is a guest" do
        get 'index'
        assigns(:active_user).should be_a(User)
        assigns(:active_user).guest?.should be_true
      end

      it "should have an active cart associated with the user" do
        get 'index'
        assigns(:active_cart).should be_a(Cart)
        assigns(:active_cart).user.should eq(assigns(:active_user))
      end
    end

    describe "logging in" do
      it "should change the active user"
      it "should add the cart if former cart was empty"
      it "should ask the user if his current cart should be added and set as active"
      it "shouldnt ask the user anything if the current cart is empty"
    end

    describe "registering" do
      it "should send an activation mail"
      it "should have the current cart as active cart"
      it "shouldnt have the guest role"
    end
  end

  describe "GET 'admin'" do
    it "returns http success" do
      get 'admin'
      response.should be_success
    end
  end
end
