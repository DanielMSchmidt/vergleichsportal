# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    name "MyString"
    ean "9783453146976"
    description "MyText"
  end
  
  factory :article_book, :class => Article do
    name "MyString"
    ean "9783453146976"
    description "MyText"
  end
  
  factory :article_not_a_book, :class => Article do
    name "Some DVD"
    ean "9713453146976"
    description "Hier steht eine Beschreibung"
  end
end
