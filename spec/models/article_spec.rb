require 'spec_helper'

describe Article do

  let(:article) { FactoryGirl.create(:article) }
  let(:provider) { FactoryGirl.create(:provider) }

  describe "attributes" do
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
    describe "description" do
      it "should be present" do
	a = Article.new(ean:"123456789-123-1", description:"Beschreibung", name:"Volkerchen")
	a.should be_valid
      end
      it "shouldn't not be present" do	
	a = Article.new(ean:"123456789-123-1", name:"Volkerchen")
	a.should be_invalid
      end
    end

    describe "name" do
      it "should be present" do
	a = Article.new(ean:"123456789-123-1", description:"Beschreibung", name:"Volkerchen")
	a.should be_valid
      end
      it "shouldn't not be present" do	
	a = Article.new(ean:"123456789-123-1", description:"Volkerchen")
	a.should be_invalid
      end
    end
  end

  describe "relations" do
    it "should have many carts" do
      should have_many(:carts).through(:article_cart_relations)
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
    it "should have many prices" do
      should have_many(:prices)
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
end
