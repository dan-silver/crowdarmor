require 'json'

class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :email, :Twitter_Handle
  validates_presence_of :name
  has_many :tweets
  has_many :alerts
  ironmq = IronMQ::Client.new :token => "f29MgpP0JbVlnDJb0ii7Cmzkwg8", :project_id => "51bc92fd2267d85283001145"
  @@queue = ironmq.queue "tweets"

  def check_alerts(tweet)
    self.alerts.each do |alert|
      if tweet.score > alert.threshold
        alert.launch(tweet)
      end
    end
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.Twitter_Handle = auth['info']['nickname'] || ""
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
    
    WorkerLauncher.launch_tweet_crawler
  end
  def getPreviousTweets
    '''tweets = Twitter.user_timeline(self.Twitter_Handle)
    tweets.each do |tweet|
      Twitter.status(tweet.id)
    end
    '''
    tweets = Twitter.mentions_timeline.each do |status|
      if self.Twitter_Handle == status.in_reply_to_screen_name and status.in_reply_to_status_id # gonna process it
        message = {
          :screen_name => status.in_reply_to_screen_name,
          :text => status.text,
          :tweet_id => status.in_reply_to_status_id
        }.to_json
        puts message
        @@queue.post(message)
      end
    end
  end
end
