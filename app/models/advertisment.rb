# encoding: utf-8
class Advertisment < ActiveRecord::Base
  attr_accessible :active, :img_url, :link_url
  validates_presence_of :img_url, :link_url
  validates :img_url, image_url: true
  validates :link_url, url: true
end
