class ArticleCartAssignment < ActiveRecord::Base
  attr_accessible :article_id, :cart_id, :quantity
  belongs_to :article
  belongs_to :cart
  validates :quantity, :presence => true
end
