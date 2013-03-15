# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "MyString"
    crypted_password "MyString"
    salt "MyString"
    active false
  end

  factory :registered_user, :class => :user do
  	email "register@example.de"
  	password "MyString"
  end
end
