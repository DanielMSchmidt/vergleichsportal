class Url < ActiveRecord::Base
  attr_accessible :article_id, :provider_id, :value
  validates :value, presence: true
  belongs_to :article
  belongs_to :provider
end
