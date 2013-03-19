require 'spec_helper'

describe Cart do
  let(:cart) { FactoryGirl.create(:cart) }
  let(:article) { FactoryGirl.create(:article) }

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
  end
end
