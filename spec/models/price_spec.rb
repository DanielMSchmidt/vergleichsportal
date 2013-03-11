require 'spec_helper'

describe Price do
  describe "validations" do
    it "should validate presence of value" do
      should validate_presence_of(:value)
    end
    it "should validate presence of provider_id" do
      should validate_presence_of(:provider_id)
    end
    it "should validate presence of article_id" do
      should validate_presence_of(:article_id)
    end
  end

  describe "relations" do
    it "should belong to a provider" do
      should belong_to(:provider)
    end
    it "should belong to an article" do
      should belong_to(:article)
    end
  end
end
