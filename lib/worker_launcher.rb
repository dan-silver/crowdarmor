require "iron_worker_ng"

class WorkerLauncher

  @@client = IronWorkerNG::Client.new
  @@current_task = false

  # Launches the tweet crawler and removes all previous instances
  # Used to refresh the list of twitter usernames being crawled
  def self.launch_tweet_crawler
    @@client.tasks.cancel(@@current_task.id) if @@current_task
    @@current_task = @@client.tasks.create("getTweets", "foo"=>"bar", "another"=>"test")
  end
end