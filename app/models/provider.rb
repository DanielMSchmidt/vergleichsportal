class Provider < ActiveRecord::Base
  attr_accessible :image_url, :name, :url
  validates :image_url, :name, :url, presence: true
  validates :image_url, image_url: true
  validates :url, url: true

  has_many :prices
end
