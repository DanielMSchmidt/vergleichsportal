class Permission < ActiveRecord::Base
  attr_accessible :value, :role_id
  has_many :permission_role_assignments
  has_many :roles, through: :permission_role_assignments
  validates :value, presence: true
end
