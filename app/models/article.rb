class Article < ActiveRecord::Base
  attr_accessible :description, :ean, :name, :author, :article_type
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
  has_many :urls

  default_scope :include => [:comments]


  def self.generate(article_hash)
    return false if article_hash[:ean].nil? || article_hash[:name].nil? || article_hash[:description].nil?

    article = Article.new(article_hash.except(:urls, :prices, :images))
    article_hash[:images].each do |key, image|
      Rails.logger.info "Article#generate called and image was type #{image.class}"

      image = image.url if (image.class == Mechanize::Page::Image)

      article.images.new(url: image)
    end
    article_hash[:prices].each do |key, value|
      article.prices.new(provider_id: key, value: value)
    end
    article_hash[:urls].each do |key, value|
      article.urls.new(provider_id: key, value: value)
    end
    article.save
    article
  end

  def available_for_each(provider_array)
    provider_array.each do |provider|
      return false unless self.available_for(provider)
    end
    true
  end

  def available_for_any(provider_array)
    provider_array.each do |provider|
      return true if self.available_for(provider)
    end
    false
  end

  def available_for(provider)
    self.prices.where(provider_id: provider).any?
  end

  def is_book?
    ean_pre = self.ean[0..2]
    return true if ean_pre == "978" or ean_pre == "979"
    false
  end

  def get_price(provider)
    price = self.prices.where(provider_id: provider)
    return price.first.value unless price.nil?
    -1
  end

  def to_s
    "ID: #{self.id}, Name: #{self.name}, Author: #{self.author}"
  end

  def average_rating
    average = 0
    if self.ratings.any?
      self.ratings.each do |r|
        average += r.value
      end
      average /= self.ratings.size
    end
    average
  end

  def add_comment(comment)
    self.comments << comment
    comment.save
    self.save
  end

  def get_price_of_day(provider_id, day)
    prices = Price.where(:article_id => self.id, :provider_id => provider_id).where(created_at: (day.beginning_of_day)..(day.end_of_day))
    price = prices.sort{|a,b| a.created_at <=> b.created_at }.last
    unless price.nil?
      price.value
    else
      0
    end
  end


  def old_price_available?(provider, time)
    Price.where(:article_id => self.id, :provider_id => provider.id).where("created_at <= ?", time).any?
  end

  def old_price(provider, time)
    Price.where(:article_id => self.id, :provider_id => provider.id).where("created_at <= ?", time).first.value
  end
end
