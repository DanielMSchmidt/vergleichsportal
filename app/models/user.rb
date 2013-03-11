class User < ActiveRecord::Base
  attr_accessible :active, :role_id, :email, :password, :password_confirmation

  authenticates_with_sorcery!

  has_many :user_role_assignments
  has_many :comments
  has_one :rating
  has_many :roles, through: :user_role_assignments
  has_many :carts

  validates :email, :role_id, presence: true
  validates :email, uniqueness: true

  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password

end
