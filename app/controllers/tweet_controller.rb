class TweetController < ApplicationController
  def processed
  	@new = Tweet.new
  	@new.score = params[:score]
  	@new.tweet_id = params[:tweet_id]
  	@new.body = params[:body]
  	@new.user = User.where(:Twitter_Handle => params[:Twitter_Handle]).first
  	render :json => @new.save
  end
  def index
  	if not current_user
  	  redirect_to "/"
  	else
  	  @tweets = current_user.tweets
  	  render "tweet/index"
    end
  end
end
