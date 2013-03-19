class SearchQueryWorker
  include Sidekiq::Worker
  sidekiq_options queue: "search_query_worker"

  def perform(query)
    Rails.logger.info "Starting SearchQueryWorker with query: #{query}"

  end
end