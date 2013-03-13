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

  def self.generate(article_hash)
    article = Article.new(article_hash.except(:url, :prices, :images))
    article_hash[:images].each do |image|
      article.images.new(url: image, imageable_id: article.id, imageable_type: "article")
    end
    article_hash[:prices].each do |key, value|
      article.prices.new(provider_id: key, value: value, article_id: article.id)
    end
    article.save
    article
  end

  def to_s
    "ID: #{self.id}, Name: #{self.name}, Author: #{self.author}"
  end
end
