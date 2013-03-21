require 'spec_helper'

describe User do
  describe "relations" do
    it "should have many carts" do
      should have_many(:carts)
    end
    it "should have many roles" do
      should have_many(:roles).through(:user_role_assignments)
    end
    it "should have many comments" do
      should have_many(:comments)
    end
    it "should have many ratings" do
      should have_many(:ratings)
    end
  end
end
