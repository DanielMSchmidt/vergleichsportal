require 'spec_helper'

describe Compare do
  describe "validations" do
    it "should belong to carts" do
      should belong_to(:cart)
    end
  end

  describe "relations" do
    it "should validate presence of cart_id" do
      should validate_presence_of(:cart_id)
    end
  end
end
