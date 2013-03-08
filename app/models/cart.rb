class Cart < ActiveRecord::Base
  attr_accessible :user_id
  has_many :article_cart_relations
  has_many :articles, through: :article_cart_relations
  has_many :compares
  belongs_to :user
end
