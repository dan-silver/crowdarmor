class Tweet < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :score, :tweet_id
end
