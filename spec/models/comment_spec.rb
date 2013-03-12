require 'spec_helper'

describe Comment do
  let(:commentShort) {FactoryGirl.build(:commentShort)}
  let(:commentMedium) {FactoryGirl.build(:commentMedium)}
  let(:commentLong) {FactoryGirl.build(:commentLong)}

  describe "attributes" do
    it "shouldn't be to short" do
      commentShort.should be_invalid
    end
    it "should be ok with a normal long comment" do
      commentMedium.should be_valid
    end
    it "shouldn't be valid with a to long comment" do
      commentLong.should be_invalid
    end
  end
  describe "validations" do
    it "should validate presence of value" do
      should validate_presence_of(:value)
    end
  end

  describe "relations" do
    it "should belong to user" do
      should belong_to(:user)
    end
    it "should belong to commentable" do
      should belong_to(:commentable)
    end
  end

end
