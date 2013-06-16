require 'json'

class User < ActiveRecord::Base
  attr_accessible :provider, :uid, :name, :email, :twitter_handle
  validates_presence_of :name
  has_many :tweets
  has_many :alerts

  def Twitter_Handle
    self.twitter_handle
  end

  def Twitter_Handle=(shit)
    self.twitter_handle=shit
  end

  def check_alerts(tweet)
    self.alerts.each do |alert|
      if tweet.score > alert.threshold
        alert.launch(tweet)
      end
    end
  end

  def self.create_with_omniauth(auth)
    user = create! do |user|
      #puts pp auth
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.twitter_handle = auth['info']['nickname'] || ""
      user.Token = auth['extra']['access_token'].params["oauth_token"] || nil
      user.TokenSecret = auth['extra']['access_token'].params["oauth_token_secret"] || nil
      if auth['extra']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
    user = User.where({:twitter_handle => auth['info']['nickname']}).first
    user.getPreviousTweets (user)
    WorkerLauncher.launch_tweet_crawler
  end
  def getPreviousTweets (user)
    puts "Launching previous tweets worker..."
    WorkerLauncher.launch_previous_tweet_worker({:Token => user.Token, :TokenSecret => user.TokenSecret, :Twitter_Handle => user.Twitter_Handle})
  end
end
