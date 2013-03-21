web: bundle exec thin start -p $PORT -e production
worker: bundle exec sidekiq -q search_query_worker,2