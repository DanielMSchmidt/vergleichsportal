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


  def send_activation_needed_email!
    super unless self.guest?
  end

  #TODO Write Tests for code below
  def self.generateGuest
    user = User.create
    role = Role.where(name: "Guest").first
    UserRoleAssignment.create(role_id: role.id, user_id: user.id)
    user
  end

  def guest?
    return true if self.roles.empty?
    self.roles.collect{|role| role.name}.include?("Guest")
  end

  def activeCart
    self.cart.last_used.first
  end

  def addCart(cart_id)
    Cart.where(id: cart_id).each do |cart|
      cart.user_id = self.id
      cart.save!
    end
  end

  def addRole(role_name)
    unless self.roles.collect{|role| role.name}.include?(role_name)
      Role.where(name: role_name).each do |role|
        UserRoleAssignment.create!(role_id: role.id, user_id: self.id)
      end
    end
  end

  def removeRole(role_name)
    self.roles.select{|role| role.name == role_name}.each do |role|
      UserRoleAssignment.where(role_id: role.id, user_id: self.id).each{|assignment| assignment.delete}
    end
  end

end
