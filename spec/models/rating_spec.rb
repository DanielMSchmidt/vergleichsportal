require 'spec_helper'

describe Rating do
  describe "validations" do
    it "should validate presence of user_id" do
      should validate_presence_of(:user_id)
    end
    it "should validate presence of rateable_id" do
      should validate_presence_of(:rateable_id)
    end
  end

  describe "relations" do
    it "should belong to carts" do
      should belong_to(:user)
    end
    it "should belong to provider" do
      should belong_to(:provider)
    end
  end
end
