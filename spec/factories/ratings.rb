# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    value       1
    user_id     1
    provider_id 1
  end
end
