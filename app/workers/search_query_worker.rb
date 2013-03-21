class SearchQueryWorker
  include Sidekiq::Worker
  sidekiq_options queue: "search_query_worker", :backtrace => true

  def perform(query)
    Rails.logger.info "Starting SearchQueryWorker with query: #{query}"
    if query.nil?
      Rails.logger.info "Stopping SearchQueryWorker with no query"
      return false
    else
      search = Search.new(query["value"], query["options"])
      search.getAllNewPrices(query)
    end
    SearchQueryWorker.perform_in(2.hours, query)
  end
end