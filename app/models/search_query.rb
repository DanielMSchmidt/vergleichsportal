class SearchQuery < ActiveRecord::Base
  require 'json'

  before_save :parse_options_to_db

  attr_accessible :value, :options
  has_many :article_query_assignments
  has_many :articles, through: :article_query_assignments

  validates :value, presence: true

  def get_options
    JSON.parse(self.options) unless self.options.nil?
  end

  private

  def parse_options_to_db
    unless self.options.nil?
      self.options = self.options.to_json
    else
      self.options = {}.to_json
    end
  end

end
