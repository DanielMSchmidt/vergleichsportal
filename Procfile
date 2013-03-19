web: bundle exec thin start -p $PORT
worker: bundle exec sidekiq -q search_query_worker,2