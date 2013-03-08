require 'spec_helper'

describe PermissionRoleAssignments do
  describe "validations" do
    it "should validate presence of role_id" do
      should validate_presence_of(:role_id)
    end
    it "should validate presence of permission_id" do
      should validate_presence_of(:permission_id)
    end
  end

  describe "relations" do
    it "should belong to roles" do
      should belong_to(:role)
    end
    it "should belong to permissions" do
      should belong_to(:permission)
    end
  end
end
