class Price < ActiveRecord::Base
  attr_accessible :value, :article_id, :provider_id
  belongs_to :article
  belongs_to :provider
end
