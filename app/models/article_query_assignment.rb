class ArticleQueryAssignment < ActiveRecord::Base
  attr_accessible :article_id, :search_query_id
  belongs_to :article
  belongs_to :search_query

  validates :article_id, :search_query_id, presence: true
end
