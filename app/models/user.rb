class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :active, :crypted_password, :email, :salt, :role_id

  has_many :user_role_assignments
  has_many :comments
  has_one :rating
  has_many :roles, through: :user_role_assignments
  has_many :carts

  validates :email, :role_id, presence: true
end
