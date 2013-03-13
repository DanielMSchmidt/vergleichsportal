class Provider < ActiveRecord::Base
  attr_accessible :image_url, :name, :url, :active
  validates :image_url, :name, :url, presence: true
  validates :image_url, image_url: true
  validates :url, url: true
  validates :active, :inclusion => {:in =>[true,false]}

  has_many :prices
  has_many :ratings, dependent: :destroy
end
