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
    it "should have many carts"
    it "should have many comments"
    it "should have many ratings"
    it "should have many images"
    it "should have many prices"
    it "should have at least one price"
  end
end
