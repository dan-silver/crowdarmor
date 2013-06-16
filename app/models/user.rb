require 'json'

class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :email, :Twitter_Handle
  validates_presence_of :name
  has_many :tweets
  has_many :alerts

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

end
