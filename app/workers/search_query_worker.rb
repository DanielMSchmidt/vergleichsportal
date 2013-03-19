class SearchQueryWorker
  include Sidekiq::Worker
  sidekiq_options queue: "search_query_worker"

  def perform(query)
    Rails.logger.info "Starting SearchQueryWorker with query: #{query}"
    search = Search.new(query.value) #TODO: Add options
    search.getAllNewestesPrices
  end
end