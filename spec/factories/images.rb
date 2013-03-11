# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    url             "MyString"
    imageable_id    1
    imageable_type  "Article"
  end
end
