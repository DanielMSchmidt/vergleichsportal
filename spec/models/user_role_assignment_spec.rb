require 'spec_helper'

describe UserRoleAssignment do
  describe "validations" do
    it "should validate presence of user_id" do
      should validate_presence_of(:user_id)
    end
    it "should validate presence of role_id" do
      should validate_presence_of(:role_id)
    end
  end

  describe "relations" do
    it "should belong to user" do
      should belong_to(:user)
    end
    it "should belong to roles" do
      should belong_to(:role)
    end
  end
end
