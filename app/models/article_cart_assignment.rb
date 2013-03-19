class ArticleCartAssignment < ActiveRecord::Base
  attr_accessible :article_id, :cart_id, :quantity
  belongs_to :article
  belongs_to :cart
  validates :quantity, :presence => true
  scope :find_for_article_and_cart, lambda { |article_id, cart_id| where(article_id: article_id, cart_id: cart_id ) }

end
