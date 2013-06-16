require "iron_worker_ng"

class WorkerLauncher

  @@client = IronWorkerNG::Client.new
  @@current_task = false
  @@current_analysis = false

  # Launches the tweet crawler and removes all previous instances
  # Used to refresh the list of twitter usernames being crawled

  def self.launch_tweet_crawler
    @@client.tasks.cancel(@@current_task.id) if @@current_task
    handles = User.select(:Twitter_Handle).collect(&:Twitter_Handle)
    puts 'Launching tweet crawler with handles:'
    puts handles
    @@current_task = @@client.tasks.create("getTweets", :handles => handles)
  end

  def self.launch_analysis_worker
    @@client.tasks.cancel(@@current_analysis.id) if @@current_analysis
    puts "Launching analysis worker"
    @@current_analysis = @@client.tasks.create("analysis_worker")
  end

  def self.launch_previous_tweet_worker (params)
    @@client.tasks.create("previousTweets", params)
  end

  def self.launch_workers
    self.launch_analysis_worker
    self.launch_tweet_crawler
  end
end