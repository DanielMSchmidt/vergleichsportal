require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'search_results'" do
    it "returns http success" do
      post 'search_results', seach_term: "Dan Brown"
      response.should be_success
    end
    describe "search" do
      before(:each) do
        3.times do |n|
          Provider.create!(image_url: "www.google.com/image#{n}.png", name: "ebay#{n}", url: "www.ebay#{n}.de")
        end
      end

      it "should start a search for each provider" do
        HomeController.should_receive(:search).exactly(3).times
        post 'search_results', seach_term: "Dan Brown"
      end

      describe "should create articles" do
        it "should add an article if it wasnt found in the database" do
          Article.should_receive(:find).and_return([])
          post 'search_results', seach_term: "Dan Brown"

        end
        it "shouldnt add an article if it was found in the database"
      end
      it "should display found articles"
    end
  end

  describe "GET 'admin'" do
    it "returns http success" do
      get 'admin'
      response.should be_success
    end
  end

end
