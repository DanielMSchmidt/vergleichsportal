class Price < ActiveRecord::Base
  default_scope :order => "created_at DESC"
  attr_accessible :value, :article_id, :provider_id
  belongs_to :article
  belongs_to :provider

  validates :value, :provider_id, presence: true
end
