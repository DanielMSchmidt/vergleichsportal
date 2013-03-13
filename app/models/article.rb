class Article < ActiveRecord::Base
  attr_accessible :description, :ean, :name, :author
  validates_format_of :ean, with: /^((\d{7}-?\d{5}-?\d)|(\d{8}-?\d{4}-?\d)|(\d{9}-?\d{3}-?\d))$/
  validates_presence_of :description, :name


  has_many :article_cart_assignments
  has_many :article_query_assignments
  has_many :carts, through: :article_cart_assignments
  has_many :comments, as: :commentable
  has_many :ratings, as: :rateable
  has_many :images, as: :imageable, dependent: :destroy
  has_many :prices
  has_many :search_queries, through: :article_query_assignments


end
