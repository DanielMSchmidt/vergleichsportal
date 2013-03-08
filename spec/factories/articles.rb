# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    name "MyString"
    ean "9783453146976"
    description "MyText"
  end
end
