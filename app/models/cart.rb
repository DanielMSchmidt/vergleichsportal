class Cart < ActiveRecord::Base
  attr_accessible :user_id
  has_many :article_cart_assignments
  has_many :articles, through: :article_cart_assignments
  has_many :compares
  belongs_to :user

  scope :last_used, order('updated_at DESC').first

  def get_count(article)
    article_cart_assignment = ArticleCartAssignment.find_for_article_and_cart(article.id, self.id)
    article_cart_assignment.quantity
  end

  def add_article(article)
    article_cart_assignment = ArticleCartAssignment.find_for_article_and_cart(article.id, self.id)
    if article_cart_assignment.nil?
      ArticleCartAssignment.create(article_id: article.id, cart_id: self.id)
    else
      article_cart_assignment.quantity += 1
      article_cart_assignment.save
    end
  end

  def remove_article(article)
    article_cart_assignment = ArticleCartAssignment.find_for_article_and_cart(article.id, self.id)
    article_cart_assignment.destroy unless article_cart_assignment.nil?
  end

  def change_article_count(article, quantity)
    assignment = ArticleCartAssignment.find_for_article_and_cart(article.id, self.id)
    assignment ||= self.add_article(article)
    if 0 < quantity
      assignment.quantity = quantity
      assignment.save
    else
      false
    end
  end
end
