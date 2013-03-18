class User < ActiveRecord::Base
  attr_accessible :active, :role_id, :email, :password, :password_confirmation

  authenticates_with_sorcery!

  has_many :user_role_assignments
  has_many :comments
  has_one :rating
  has_many :roles, through: :user_role_assignments
  has_many :carts

  validates :email, :role_id, presence: true, :unless => :guest?
  validates :email, uniqueness: true, :unless => :guest?

  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password, :unless => :guest?
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password, :unless => :guest?


  # Write Tests for code below
  def self.generateGuest
    user = User.create
    Role.where(name: "Guest").each do |role|
      UserRoleAssignment.create(role_id: role.id, user_id: user.id)
    end
    user
  end

  def addRole(rolename)
    Role.where(name: rolename).each do |role|
      UserRoleAssignment.create(role_id: role.id, user_id: self.id)
    end
  end

  def guest?
    return true if self.roles.empty?
    self.roles.collect{|role| role.name}.includes("Guest")
  end
end
