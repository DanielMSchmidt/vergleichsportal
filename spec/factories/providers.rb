# encoding: utf-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :provider_buch, :class => Provider do
    name "buchDe"
    url "http://www.google.com"
    image_url "http://www.google.de/test.png"
    active true
  end

  factory :provider_thalia, :class => Provider do
    name "thaliaDe"
    url "http://www.google.com"
    image_url "http://www.google.de/test.png"
    active true
  end
  
  factory :provider_buecher, :class => Provider do
    name "bücherDe"
    url "http://www.google.com"
    image_url "http://www.google.de/test.png"
    active true
  end
  
  factory :provider_ebay, :class => Provider do
    name "ebay"
    url "http://www.google.com"
    image_url "http://www.google.de/test.png"
    active true
  end
end
