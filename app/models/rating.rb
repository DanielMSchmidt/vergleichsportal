class Rating < ActiveRecord::Base
  attr_accessible :value, :rateable_id, :rateable_type
  belongs_to :rateable, :polymorphic => true
end
