class User < ActiveRecord::Base
  attr_accessible :active, :crypted_password, :email, :salt, :role_id
end
