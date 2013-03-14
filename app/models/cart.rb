class Cart < ActiveRecord::Base
  attr_accessible :user_id
  has_many :article_cart_assignments
  has_many :articles, through: :article_cart_assignments
  has_many :compares
  belongs_to :user

  def add_article(article)
    ArticleCartAssignment.create(article_id: article.id, cart_id: self.id)
  end

  def remove_article(article)
    ArticleCartAssignment.find(:first,
			       :conditions => {
				  :article_id => article.id, 
				  :cart_id => self.id}).destroy
  end
end
