require 'spec_helper'

describe Comment do




  describe "attributes" do
    it "shouldn't be to short" do
      comment_short = FactoryGirl.build(:commentShort)
      comment_short.should be_invalid
    end
    it "should be ok with a normal long comment" do
      comment_medium = FactoryGirl.build(:commentMedium)
      comment_medium.should be_valid
    end
    it "shouldn't be valid with a to long comment" do
      comment_long = FactoryGirl.build(:commentLong)
      comment_long.should be_invalid
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
