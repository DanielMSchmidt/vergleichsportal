require 'spec_helper'

describe Article do
  let(:article) { FactoryGirl.create(:article) }
  let(:provider) { FactoryGirl.create(:provider_buch) }
  let!(:image) { FactoryGirl.create(:image) }

  describe "attributes" do
    #TODO: Refactor this part with custom matcher for ean
    describe "ean" do
      it "should be valid with a right ean-13" do
        a = Article.new(ean:"1234567-12345-1", description:"Beschreibung", name:"Volker")
        a.should be_valid
      end
      it "should be invalid with a false ean" do
        a = Article.new(ean:"123456789-12345-1", description:"Beschreibung", name:"Volkerchen")
        a.should be_invalid
      end
    end
    it "should validate presence of description" do
      should validate_presence_of(:description)
    end

    it "should validate presence of name" do
      should validate_presence_of(:name)
    end
  end

  describe "relations" do
    it "should have many carts" do
      should have_many(:carts).through(:article_cart_assignments)
    end
    it "should have many comments" do
      should have_many(:comments)
    end
    it "should have many ratings" do
      should have_many(:ratings)
    end
    it "should have many images" do
      should have_many(:images)
    end
    it "should have images which are dependent destroy" do
      expect{ article.destroy }.to change{Image.count}.from(1).to(0)
    end
    it "should have many prices" do
      should have_many(:prices)
    end
    it "should have many queries" do
      should have_many(:search_queries).through(:article_query_assignments)
    end

    describe "the number of prices" do
      it "should be invalid without a price per provider" do
        Provider.stub(:count).and_return(1)
        should raise_error
      end
      it "should be valid with one price per provider" do
        article.prices.create(value: 10.3, provider_id: provider.id)
        article.should be_valid
      end
    end
  end

  describe "methods" do
    it "should have a generate method" do
      Article.should respond_to(:generate)
    end
    it "should have a available for method" do
      should respond_to(:available_for)
    end
  end
end
