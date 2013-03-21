#encoding: utf-8
require 'spec_helper'

describe Cart do
  let(:cart) { FactoryGirl.create(:cart) }
  let(:article) { FactoryGirl.create(:article) }
  let(:cart_w_books) { FactoryGirl.create(:cart) }
  let(:cart_wo_books) { FactoryGirl.create(:cart) }
  let(:book) { FactoryGirl.create(:article_book) }
  let(:blurays) { FactoryGirl.create(:article_not_a_book) }
  let(:buch) { FactoryGirl.create(:provider_buch) }
  let(:buecher) { FactoryGirl.create(:provider_buecher) }
  let(:thalia) { FactoryGirl.create(:provider_thalia) }
  let(:ebay) { FactoryGirl.create(:provider_ebay) }
  
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
    describe "count articles" do
      it "should be 1" do
        Price.create(:article_id => blurays.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => blurays.id, :provider_id => buecher.id, :value => "20.02")
        Price.create(:article_id => blurays.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => blurays.id, :provider_id => ebay.id, :value => "19.99")
        
        Price.create(:article_id => book.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => buecher.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => book.id, :provider_id => ebay.id, :value => "19.99")
    
	ArticleCartAssignment.create(:article_id => book.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_wo_books.id)
	cart_w_books.get_count(book).should == 1
	Price.all.each{|x| x.destroy}
	ArticleCartAssignment.all.each{|x| x.destroy}
      end
    end
    describe "cart with books" do
      it "should cost at ebay 39,98" do
        Price.create(:article_id => blurays.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => blurays.id, :provider_id => buecher.id, :value => "20.02")
        Price.create(:article_id => blurays.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => blurays.id, :provider_id => ebay.id, :value => "19.99")
        
        Price.create(:article_id => book.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => buecher.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => book.id, :provider_id => ebay.id, :value => "19.99")
    
	ArticleCartAssignment.create(:article_id => book.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_wo_books.id)
	cart_w_books.calculate_overall_price(ebay).to_s.should == "39.98"
	Price.all.each{|x| x.destroy}
	ArticleCartAssignment.all.each{|x| x.destroy}
      end
      it "should cost at buch.de 19.98" do
        Price.create(:article_id => blurays.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => blurays.id, :provider_id => buecher.id, :value => "20.02")
        Price.create(:article_id => blurays.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => blurays.id, :provider_id => ebay.id, :value => "19.99")
        
        Price.create(:article_id => book.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => buecher.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => book.id, :provider_id => ebay.id, :value => "19.99")
    
	ArticleCartAssignment.create(:article_id => book.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_wo_books.id)
	cart_w_books.calculate_overall_price(buch).to_s.should == "19.98"
	Price.all.each{|x| x.destroy}
	ArticleCartAssignment.all.each{|x| x.destroy}
      end
      it "should cost at thalia 15,98" do
        Price.create(:article_id => blurays.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => blurays.id, :provider_id => buecher.id, :value => "20.02")
        Price.create(:article_id => blurays.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => blurays.id, :provider_id => ebay.id, :value => "19.99")
        
        Price.create(:article_id => book.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => buecher.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => book.id, :provider_id => ebay.id, :value => "19.99")
    
	ArticleCartAssignment.create(:article_id => book.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_wo_books.id)
	cart_w_books.calculate_overall_price(thalia).to_s.should == "15.98"
	Price.all.each{|x| x.destroy}
	ArticleCartAssignment.all.each{|x| x.destroy}
      end
      it "should cost at buecher.de 109,98" do
        Price.create(:article_id => blurays.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => blurays.id, :provider_id => buecher.id, :value => "20.02")
        Price.create(:article_id => blurays.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => blurays.id, :provider_id => ebay.id, :value => "19.99")
        
        Price.create(:article_id => book.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => buecher.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => book.id, :provider_id => ebay.id, :value => "19.99")
    
	ArticleCartAssignment.create(:article_id => book.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_wo_books.id)
	cart_w_books.calculate_overall_price(buecher).to_s.should == "30.01"
	Price.all.each{|x| x.destroy}
	ArticleCartAssignment.all.each{|x| x.destroy}
      end
    end
    describe "cart without books" do
      it "should cost at ebay 19,99" do
        Price.create(:article_id => blurays.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => blurays.id, :provider_id => buecher.id, :value => "20.02")
        Price.create(:article_id => blurays.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => blurays.id, :provider_id => ebay.id, :value => "19.99")
        
        Price.create(:article_id => book.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => buecher.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => book.id, :provider_id => ebay.id, :value => "19.99")
    
	ArticleCartAssignment.create(:article_id => book.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_wo_books.id)
	cart_wo_books.calculate_overall_price(ebay).to_s.should == "19.99"
	Price.all.each{|x| x.destroy}
	ArticleCartAssignment.all.each{|x| x.destroy}
      end
      it "should cost at buch 12,99" do
        Price.create(:article_id => blurays.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => blurays.id, :provider_id => buecher.id, :value => "20.02")
        Price.create(:article_id => blurays.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => blurays.id, :provider_id => ebay.id, :value => "19.99")
        
        Price.create(:article_id => book.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => buecher.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => book.id, :provider_id => ebay.id, :value => "19.99")
    
	ArticleCartAssignment.create(:article_id => book.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_wo_books.id)
	cart_wo_books.calculate_overall_price(buch).to_s.should == "12.99"
	Price.all.each{|x| x.destroy}
	ArticleCartAssignment.all.each{|x| x.destroy}
      end
      it "should cost at buecher 99,99" do
        Price.create(:article_id => blurays.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => blurays.id, :provider_id => buecher.id, :value => "20.02")
        Price.create(:article_id => blurays.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => blurays.id, :provider_id => ebay.id, :value => "19.99")
        
        Price.create(:article_id => book.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => buecher.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => book.id, :provider_id => ebay.id, :value => "19.99")
    
	ArticleCartAssignment.create(:article_id => book.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_wo_books.id)
	cart_wo_books.calculate_overall_price(buecher).to_s.should == "20.02"
	Price.all.each{|x| x.destroy}
	ArticleCartAssignment.all.each{|x| x.destroy}
      end
      it "should cost at thalia 10,99" do
        Price.create(:article_id => blurays.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => blurays.id, :provider_id => buecher.id, :value => "20.02")
        Price.create(:article_id => blurays.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => blurays.id, :provider_id => ebay.id, :value => "19.99")
        
        Price.create(:article_id => book.id, :provider_id => buch.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => buecher.id, :value => "9.99")
        Price.create(:article_id => book.id, :provider_id => thalia.id, :value => "7.99")
        Price.create(:article_id => book.id, :provider_id => ebay.id, :value => "19.99")
    
	ArticleCartAssignment.create(:article_id => book.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_w_books.id)
        ArticleCartAssignment.create(:article_id => blurays.id, :cart_id => cart_wo_books.id)
	cart_wo_books.calculate_overall_price(thalia).to_s.should == "10.99"
	Price.all.each{|x| x.destroy}
	ArticleCartAssignment.all.each{|x| x.destroy}
      end
    end
  end
  describe "functions" do
    describe "add_article" do
      it "should add an assignment if none was allready there" do
        ArticleCartAssignment.all.each{|x| x.delete}
        expect{ cart.add_article(article) }.to change{ArticleCartAssignment.count}.by(1)
      end
      it "should increase the quanitity attribute of the assignment if one was there" do
        expect{ cart.add_article(article) }.to change{ArticleCartAssignment.count}.by(1)
        expect{ cart.add_article(article) }.to change{ArticleCartAssignment.count}.by(0)
        expect{ cart.add_article(article) }.to change{ArticleCartAssignment.find_for_article_and_cart(article.id, cart.id).first.quantity}.by(1)
      end
    end
    describe "remove_article" do
      it "should decrease quantity by one, delete the item an do nothing" do
	cart.add_article(book)
	cart.add_article(book)
	expect{ cart.remove_article(book) }.to  change{ArticleCartAssignment.count}.by(0)
	expect{ cart.remove_article(book) }.to  change{ArticleCartAssignment.count}.by(-1)
	expect{ cart.remove_article(book) }.to  change{ArticleCartAssignment.count}.by(0)
      end
    end
    describe "change article count" do
      it "shouldn't do anything if new count negativ" do
	cart.add_article(book)
	cart.change_article_count(book, -1)
	cart.get_count(book).should == 1
      end
    end
    describe "empty?" do
      it "should return true if no article in cart" do
	cart.empty?.should == true
      end
      it "should return false if there is an article in cart" do
	ArticleCartAssignment.create(:article_id => book.id, :cart_id => cart_w_books.id)
	cart_w_books.empty?.should == false
	ArticleCartAssignment.all.each{|x| x.destroy}
      end
    end
    describe "price_history" do
      it "shoudl work" do
	ebay
	buch
	thalia
	buecher
	cart.price_history.sort.should == {:data=>[[0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]], :labels=>"#{(7.day.ago.to_date..Date.today).collect{ |date| date.strftime("%b %d") }.to_s}", :provider_names=>["Ebay.de", "Buch.de", "Thalia.de", "Bücher.de"]}.sort
      end
    end
  end
end
