class Provider < ActiveRecord::Base
  scope :active, where(active: true)
  attr_accessible :image_url, :name, :url, :active
  validates :image_url, :name, :url, presence: true
  validates :image_url, image_url: true
  validates :url, url: true

  has_many :prices
  has_many :ratings, dependent: :destroy
  has_many :urls

  def average_rating
  	average = 0
    if self.ratings
      self.ratings.each do |r|
        average += r.value
      end
      average /= self.ratings.size
    end
    average
  end
end
