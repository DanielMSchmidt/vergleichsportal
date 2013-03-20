class SearchQuery < ActiveRecord::Base
  attr_accessible :value, :options
  has_many :article_query_assignments
  has_many :articles, through: :article_query_assignments

  validates :value, presence: true
end
