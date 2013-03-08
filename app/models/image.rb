class Image < ActiveRecord::Base
  attr_accessible :url, :imageable_id, :imageable_type
  belongs_to :imageable, :polymorphic => true

  validates :imageable_id, :imageable_type, presence: true
end
