class Compare < ActiveRecord::Base
  attr_accessible :cart_id
  belongs_to :cart

  validates :cart_id, presence: true
end
