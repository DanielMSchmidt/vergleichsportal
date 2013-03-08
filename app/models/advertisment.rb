# encoding: utf-8
class Advertisment < ActiveRecord::Base
  attr_accessible :active, :img_url, :link_url
  validates_presence_of :img_url, :link_url
  validates_format_of :img_url, with: /^(http:\/\/){0,1}(www.){0,1}(\w|-|ö|ä|ü)*\.(\w){2,3}(\/(\/|\S)*){1}(\.png|\.jpg|\.bmp|\.png)$/
  validates_format_of :link_url, with: /^(http:\/\/){0,1}(www.){0,1}(\w|-|ö|ä|ü)*\.(\w){2,3}(\/(\/|\S)*){0,1}$/
end
