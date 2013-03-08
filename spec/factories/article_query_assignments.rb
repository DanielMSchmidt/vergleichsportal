# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article_query_assignment, :class => 'ArticleQueryAssignment' do
    article_id 1
    search_query_id 1
  end
end
