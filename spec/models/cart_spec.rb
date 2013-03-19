require 'spec_helper'

describe Cart do
  cart = FactoryGirl.create(:cart)
  cart_wo_books = Cart.create()
  book = FactoryGirl.create(:article_book)
  article = FactoryGirl.create(:article_not_a_book)
  buch = FactoryGirl.create(:provider_buch)
  buecher = FactoryGirl.create(:provider_buecher)
  thalia = FactoryGirl.create(:provider_thalia)
  ebay = FactoryGirl.create(:provider_ebay)
  
  Price.create(:article_id => article.id, :provider_id => buch.id, :value => "9.99")
  Price.create(:article_id => article.id, :provider_id => buecher.id, :value => "20.02")
  Price.create(:article_id => article.id, :provider_id => thalia.id, :value => "7.99")
  Price.create(:article_id => article.id, :provider_id => ebay.id, :value => "19.99")
  
  Price.create(:article_id => book.id, :provider_id => buch.id, :value => "9.99")
  Price.create(:article_id => book.id, :provider_id => buecher.id, :value => "9.99")
  Price.create(:article_id => book.id, :provider_id => thalia.id, :value => "7.99")
  Price.create(:article_id => book.id, :provider_id => ebay.id, :value => "19.99")

  ArticleCartAssignment.create(:article_id => book.id, :cart_id => cart.id)
  ArticleCartAssignment.create(:article_id => article.id, :cart_id => cart.id)
  ArticleCartAssignment.create(:article_id => article.id, :cart_id => cart_wo_books.id)
  describe "relations" do
    it "should have many articles" do
      should have_many(:articles).through(:article_cart_assignments)
    end

    it "should have many compares" do
      should have_many(:compares)
    end

    it "should belong to a user" do
      should belong_to(:user)
    end
  end

  describe "calculating" do
    describe "cart with books" do
      it "should cost at ebay 39,98" do
	cart.calculate_overall_price(ebay).to_s.should == "39.98"
      end
      it "should cost at buch.de 19.98" do
	cart.calculate_overall_price(buch).to_s.should == "19.98"
      end
      it "should cost at thalia 15,98" do
	cart.calculate_overall_price(thalia).to_s.should == "15.98"
      end
      it "should cost at buecher.de 109,98" do
	cart.calculate_overall_price(buecher).to_s.should == "30.01"
      end
    end
    describe "cart without books" do
      it "should cost at ebay 19,99" do
	cart_wo_books.calculate_overall_price(ebay).to_s.should == "19.99"
      end
      it "should cost at buch 12,99" do
	cart_wo_books.calculate_overall_price(buch).to_s.should == "12.99"
      end
      it "should cost at buecher 99,99" do
	cart_wo_books.calculate_overall_price(buecher).to_s.should == "20.02"
      end
      it "should cost at thalia 10,99" do
	cart_wo_books.calculate_overall_price(thalia).to_s.should == "10.99"
      end
    end
  end
end
