class SearchQueryWorker
  include Sidekiq::Worker
  sidekiq_options queue: "search_query_worker"

  def perform(query)
    Rails.logger.info "Starting SearchQueryWorker with query: #{query}"
    if query.nil? || query.empty?
      Rails.logger.info "Stopping SearchQueryWorker with empty query"
      return false
    else
      search = Search.new(query[:value]) #TODO: Add options
      search.getAllNewestesPrices
    end
  end
end