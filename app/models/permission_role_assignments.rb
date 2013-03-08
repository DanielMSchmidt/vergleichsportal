class PermissionRoleAssignments < ActiveRecord::Base
  attr_accessible :permission_id, :role_id
  belongs_to :role
  belongs_to :permission

  validates :permission_id, :role_id, presence: true
end
