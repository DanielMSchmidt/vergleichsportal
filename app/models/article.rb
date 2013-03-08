class Article < ActiveRecord::Base
  attr_accessible :description, :ean, :name
  validates_format_of :ean, with: /^((\d{7}-?\d{5}-?\d)|(\d{8}-?\d{4}-?\d)|(\d{9}-?\d{3}-?\d))$/
  validates_presence_of :description, :name
  validate :it_has_at_least_one_price_per_provider

  has_many :article_cart_assignments
  has_many :article_query_assignments
  has_many :carts, through: :article_cart_assignments
  has_many :comments, as: :commentable
  has_many :ratings, as: :rateable
  has_many :images, as: :imageable, dependent: :destroy
  has_many :prices
  has_many :search_queries, through: :article_query_assignments


  def it_has_at_least_one_price_per_provider
    if Provider.count > self.prices.count
      errors.add(:prices, 'There has to be at least one price per provider')
    end
  end
end
