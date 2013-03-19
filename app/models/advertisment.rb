# encoding: utf-8
class Advertisment < ActiveRecord::Base
  attr_accessible :active, :img_url, :link_url
  validates_presence_of :img_url, :link_url
  validates :img_url, image_url: true
  validates :link_url, url: true
  validates :active, :inclusion => {:in =>[true,false]}

  scope :active, where(:active => true)
  scope :inactive, where(:active => false)

  def activate
    ads = Advertisment.where(:active => true)
    ads.each{|x| x.deactivate}
    self.active = true
    self.save
  end
  def deactivate
    self.active = false
    self.save
  end
end
