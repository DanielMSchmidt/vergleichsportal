class Comment < ActiveRecord::Base
  attr_accessible :value, :commentable_id, :commentable_type
  belongs_to :imageable, :polymorphic => true
end
