class Article < ActiveRecord::Base
  attr_accessible :description, :ean, :name
end
