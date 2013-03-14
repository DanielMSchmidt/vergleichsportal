require 'spec_helper'

describe Image do
  let(:article) { FactoryGirl.create(:article) }
  let(:image) { FactoryGirl.create(:image) }

  describe "validations" do
  end

  describe "relations" do
    it "should belong to article" do
      should belong_to(:imageable)
    end
  end
end