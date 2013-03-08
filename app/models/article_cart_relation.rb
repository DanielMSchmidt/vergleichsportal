class ArticleCartRelation < ActiveRecord::Base
  attr_accessible :article_id, :cart_id
  belongs_to :article
  belongs_to :cart
end
