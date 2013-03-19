require 'spec_helper'

describe Cart do
  let(:cart) { FactoryGirl.create(:cart) }
  cart_wo_books = Cart.create()
  book = FactoryGirl.create(:article_book)
  article = FactoryGirl.create(:article_not_a_book)
  buch = FactoryGirl.create(:provider_buch)
  buecher = FactoryGirl.create(:provider_buecher)
  thalia = FactoyGirls.create(:provider_thalia)
  ebay = FactoryGirls.create(:provider_ebay)
  
  Price.create(:article_id => article, :provider_id => buch, :value => "9.99")
  Price.create(:article_id => article, :provider_id => buecher, :value => "99.99")
  Price.create(:article_id => article, :provider_id => thalia, :value => "7.99")
  Price.create(:article_id => article, :provider_id => ebay, :value => "19.99")
  
  Price.create(:article_id => book, :provider_id => buch, :value => "9.99")
  Price.create(:article_id => book, :provider_id => buecher, :value => "9.99")
  Price.create(:article_id => book, :provider_id => thalia, :value => "7.99")
  Price.create(:article_id => book, :provider_id => ebay, :value => "19.99")

  ArticleCartAssignment.create(:article_id => book, :cart_id => cart)
  ArticleCartAssignment.create(:article_id => article, :cart_id => cart)
  ArticleCartAssignment.create(:article_id => article, :cart_id => cart_wo_books)
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

end
