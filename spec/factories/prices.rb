# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :price do
    value "9.99"
  end
  
  factory :price_low, :class => Price do
    value "2.99"
  end
  
  factory :price_high, :class => Price do
    value "99.99"
  end
end
