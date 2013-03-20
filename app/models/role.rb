class Role < ActiveRecord::Base
  attr_accessible :name
  has_many :permission_role_assignments
  has_many :permissions, through: :permission_role_assignments
  has_many :users
  validates :name, presence: true

end
