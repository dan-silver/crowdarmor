class Tweet < ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :score, :tweet_id, :tweet_type
  validates :tweet_type, :inclusion => { :in => ['primary', 'reply'],
    :message => "%{value} is not a valid type" }

  after_save :calculate_primary_score

  # lol wut is good design?
  def type= (type)
    self.tweet_type = type
  end
  def type
    self.tweet_type
  end

  def primary
    if self.tweet_type == 'primary'
      return self
    else
      return Tweet.where(:tweet_type => 'primary', :tweet_id => self.tweet_id).first
    end
  end

  def replies
    if self.tweet_type != 'primary'
      raise 'Only primary tweets can have replies!'
    else
      return Tweet.where(:tweet_type => 'reply', :tweet_id => self.tweet_id)
    end
  end

  def calculate_score!
    if self.tweet_type != 'primary'
      raise 'You can only calculate score for a primary tweet!'
    else
      self.score = self.replies.collect(&:score).sum.to_f/self.replies.size
      self.save!
    end
  end

  private
  def calculate_primary_score
    if self.type == 'reply'
      self.primary.calculate_score!
    end
  end
end
