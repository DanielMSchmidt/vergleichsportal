require 'spec_helper'

describe Permission do
  describe "validations" do
    it "should validate presence of value" do
      should validate_presence_of(:value)
    end
  end

  describe "relations" do
    it "should belong to carts" do
      should have_many(:roles).through(:permission_role_assignments)
    end
  end
end
