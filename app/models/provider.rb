class Provider < ActiveRecord::Base
  scope :active, where(active: true)
  attr_accessible :image_url, :name, :url, :active, :display_name
  validates :image_url, :name, :url, :display_name, presence: true
  validates :image_url, image_url: true
  validates :url, url: true

  has_many :prices
  has_many :ratings, dependent: :destroy
  has_many :urls

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
end
