class Comment < ActiveRecord::Base
  attr_accessible :value, :commentable_id, :commentable_type, :user_id
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  
  validates :value, presence: true,
	    :length => { :in => 50..1500 }
end
