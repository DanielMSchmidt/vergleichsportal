require 'spec_helper'

describe Image do
  let(:article) { FactoryGirl.create(:article) }
  let(:image) { FactoryGirl.create(:image) }

  describe "validations" do
    it "should validate presence of article_id" do
      should validate_presence_of(:imageable_id)
      should validate_presence_of(:imageable_type)
    end
  end

  describe "relations" do
    it "should belong to article" do
      should belong_to(:imageable)
    end
  end
end