require 'spec_helper'

describe Cart do
  let(:cart) { FactoryGirl.create(:cart) }

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
end
