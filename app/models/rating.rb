class Rating < ActiveRecord::Base
  attr_accessible :value, :rateable_id, :rateable_type, :user_id
  belongs_to :rateable, :polymorphic => true
  belongs_to :user
  belongs_to :provider

  validates :user_id, presence: true
  validates :rateable_id, presence: true
end
