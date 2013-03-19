# Use this file to easily define all of your cron jobs.

every 2.hours do
  runner "SearchQueryLaunchWorker.perform_async" #Start the Worker every 2 hours
end
