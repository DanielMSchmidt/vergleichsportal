class Rating < ActiveRecord::Base
  attr_accessible :value, :rateable_id, :rateable_type, :user_id, :provider_id
  belongs_to :rateable, :polymorphic => true
  belongs_to :user
  belongs_to :provider

  validates :user_id, :provider_id, presence: true
end
