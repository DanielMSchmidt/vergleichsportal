require 'spec_helper'

describe Comment do
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
