# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :provider_buch do
    name "buchDe"
    url "www.google.com"
    image_url "www.google.de/test.png"
    active true
  end

  factory :provider_thalia do
    name "thaliaDe"
    url "www.google.com"
    image_url "www.google.de/test.png"
    active true
  end
  
  factory :provider_buecher do
    name "bücherDe"
    url "www.google.com"
    image_url "www.google.de/test.png"
    active true
  end
  
  factory :provider_ebay do
    name "ebay"
    url "www.google.com"
    image_url "www.google.de/test.png"
    active true
  end
end
