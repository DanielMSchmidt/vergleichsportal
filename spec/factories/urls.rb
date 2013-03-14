# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :url do
    value "MyString"
    article_id 1
    provider_id 1
  end
end
