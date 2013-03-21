require 'spec_helper'

describe Provider do
  let(:provider) { FactoryGirl.create(:provider_buch) }
  let(:user) { FactoryGirl.create(:user) }

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
      it "should fail if it isn't an url" do
        provider.url = "notavalidurl"
        provider.should_not be_valid
      end
      it "should succeed if it is an url" do
        provider.should be_valid
      end
    end

    it "should delete its ratings if deleted" do
      provider.ratings.create(user_id:user.id, rateable_type:"provider", rateable_id:provider.id)
      expect {provider.destroy}.to change{Rating.count}.by(-1)
    end
  end

  describe "relations" do
    it "should belong to carts" do
      should have_many(:prices)
    end
  end
end
