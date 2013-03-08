require 'spec_helper'

describe Role do
  describe "validations" do
    it "should validate presence of name" do
      should validate_presence_of(:name)
    end
  end

  describe "relations" do
    it "should have many user" do
      should have_many(:users)
    end
  end
end
