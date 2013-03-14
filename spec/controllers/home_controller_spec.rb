require 'spec_helper'

describe HomeController do

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
      post 'search_results', search:{term: "Dan Brown"}
      HomeController.stub(:search)
      HomeController.stub(:merge).and_return([])
      response.should be_success
    end
    describe "search" do
      before(:each) do
        3.times do |n|
          #TODO: Refactor with factory girl
          Provider.create!(image_url: "www.google.com/image#{n}.png", name: "ebay#{n}", url: "www.ebay#{n}.de", active: true)
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

  describe "GET 'admin'" do
    it "returns http success" do
      get 'admin'
      response.should be_success
    end
  end

end
