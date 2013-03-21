# encoding: utf-8
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :provider_buch, :class => Provider do
    display_name "Buch.de"
    name "buchDe"
    url "http://www.google.com"
    image_url "http://www.google.de/test.png"
    active true
  end

  factory :provider_thalia, :class => Provider do
    display_name "Thalia.de"
    name "thaliaDe"
    url "http://www.google.com"
    image_url "http://www.google.de/test.png"
    active true
  end

  factory :provider_buecher, :class => Provider do
    display_name "Bücher.de"
    name "bücherDe"
    url "http://www.google.com"
    image_url "http://www.google.de/test.png"
    active true
  end

  factory :provider_ebay, :class => Provider do
    display_name "Ebay.de"
    name "ebay"
    url "http://www.google.com"
    image_url "http://www.google.de/test.png"
    active true
  end
end
