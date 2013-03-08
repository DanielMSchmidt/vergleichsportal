class Article < ActiveRecord::Base
  attr_accessible :description, :ean, :name
  has_many :article_cart_relations
  has_many :carts, through: :article_cart_relations
  has_many :comments, as: :commentable
  has_many :ratings, as: :rateable
  has_many :images, as: :imageable
  has_many :prices


end
