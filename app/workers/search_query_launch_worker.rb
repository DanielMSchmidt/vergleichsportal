class SearchQueryLaunchWorker
  include Sidekiq::Worker
  sidekiq_options queue: "search_query_launch_worker"

  def perform
    SearchQuery.all.each do |query|
      SearchQueryWorker.perform_async(query)
    end
  end
end