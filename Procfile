web: rails s puma -p $PORT
worker: bundle exec sidekiq -q search_query_launch_worker,5 search_query_worker