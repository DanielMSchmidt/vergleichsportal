require 'spec_helper'

describe Article do
  describe "attributes" do
    describe "ean" do
      it "should be valid with right url"
      it "should be invalid with right url"
    end
    describe "description" do
      it "should be present"
    end

    describe "name" do
      it "should be present"
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
      it "should be invalid without a price"
      it "should be valid with a price"
    end
  end
end
