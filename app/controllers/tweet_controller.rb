class TweetController < ApplicationController
  def processed
    
  	tweet = Tweet.new
  	tweet.score = params[:score]
  	tweet.tweet_id = params[:tweet_id]
  	tweet.body = params[:body]
  	tweet.user = User.where(:Twitter_Handle => params[:Twitter_Handle]).first
    tweet.type = 'reply'

    save_original_tweet(tweet)

  	render :json => tweet.save
  end

  def index
    if not current_user
      redirect_to "/"
    else
      @tweets = current_user.tweets
      render "tweet/index"
    end
  end


  private
  def save_original_tweet(tweet)
    unless Tweet.where(:tweet_id => tweet.tweet_id).count > 0
      primary = Tweet.new
      primary.tweet_id = tweet.tweet_id
      primary.score = tweet.score # aggregates starts as one reply score
      primary.user = tweet.user
      primary.type = 'primary'
      primary.body = Twitter.status(tweet.tweet_id).text #twitter gem here
    end
  end

end
