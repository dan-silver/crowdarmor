class Tweet < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :score, :tweet_id, :tweet_type
  validates :tweet_type, :inclusion => { :in => ['primary', 'reply'],
    :message => "%{value} is not a valid type" }

  def type= (type)
    self.tweet_type = type
  end
  def type
    self.tweet_type
  end
end
