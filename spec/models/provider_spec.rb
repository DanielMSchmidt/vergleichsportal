require 'spec_helper'

describe Provider do
  describe "validations" do
    it "should validate presence of image_url" do
      should validate_presence_of(:image_url)
    end
    it "should validate presence of name" do
      should validate_presence_of(:name)
    end
    it "should validate presence of url" do
      should validate_presence_of(:url)
    end
    describe "should validate that url is a url" do
      it "should fail if it isn't an url"
      it "should succeed if it is an url"
    end

  end

  describe "relations" do
    it "should belong to carts" do
      should have_many(:prices)
    end
  end
end
