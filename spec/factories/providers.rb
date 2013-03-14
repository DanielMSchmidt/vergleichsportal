# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :provider do
    name "MyString"
    url "www.google.com"
    image_url "www.google.de/test.png"
    active true
  end
end
