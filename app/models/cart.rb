# encoding: utf-8
class Cart < ActiveRecord::Base
  attr_accessible :user_id
  has_many :article_cart_assignments
  has_many :articles, through: :article_cart_assignments
  has_many :compares
  belongs_to :user

  def get_count(article)
    article_cart_assignment = ArticleCartAssignment.find(:first,
							 :conditions => {
							  :article_id => article.id, 
							  :cart_id => self.id})
    article_cart_assignment.quantity
  end

  def add_article(article)
    article_cart_assignment = ArticleCartAssignment.find(:first,
							 :conditions => {
							  :article_id => article.id, 
							  :cart_id => self.id})
    if article_cart_assignment.nil?
      ArticleCartAssignment.create(article_id: article.id, cart_id: self.id)
    else
      article_cart_assignment.quantity += 1
      article_cart_assignment.save
    end
  end

  def remove_article(article)
    article_cart_assignment = ArticleCartAssignment.find(:first,
							 :conditions => {
							  :article_id => article.id, 
							  :cart_id => self.id})
    article_cart_assignment.destroy unless article_cart_assignment.nil?
  end

  def change_article_count(article, quantity)
    assignment = ArticleCartAssignment.find(:first,
					    :conditions => {
					      :article_id => article.id,
					      :cart_id => self.id})
    assignment ||= self.add_article(article)
    if 0<quantity
      assignment.quantity = quantity
      assignment.save
    else
      false
    end
  end

  def is_book_in_cart?
    self.articles.each do |article|
      return true if article.is_book?
    end
    false
  end

  def calc_shipping(provider)
    return 0 if provider.name == "ebay" or provider.name == "bücherDe"
    return 0 if self.is_book_in_cart?
    article_price = self.price_of_all_articles(provider)
    return 3 if article_price < 20
    0
  end

  def price_of_all_articles(provider)
    price = 0
    self.articles.each do |article|
      price += article.get_price(provider)
    end
    price
  end

  def available_for(provider)
    self.articles.each do |article|
      return false unless article.available_for(provider)
    end
    true
  end

  def calculate_overall_price(provider)
    return -1 unless self.available_for(provider)
    self.price_of_all_articles + self.calc_shipping
  end
end
