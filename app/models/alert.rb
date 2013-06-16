class Alert < ActiveRecord::Base
  belongs_to :user
  attr_accessible :action_type, :data, :threshold
  after_save :check_if_first

  def launch(tweet)
    case self.action_type
    when 'SMS'
      puts 'Send an SMS about tweet.' 
      sendSMS tweet
    when 'Email'
      puts 'Send an email about tweet.'
      Notifier.alert_email(self.data, tweet).deliver
    when 'Remove Post'
      puts 'Removing tweet.'
      @client = Twitter::Client.new(
        :oauth_token => alert.user[:Token],
        :oauth_token_secret => alert.user[:TokenSecret]
      )
      @client.status_destroy(tweet.tweet_id)
    end
  end
  def check_if_first
    if self.user.size == 1
      self.user.getPreviousTweets(self.user)
    end
  end
  def self.valid_types
    [
      'SMS',
      'Email',
      'Remove Post'
    ]
  end
  def sendSMS(tweet)
    @client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
    @client.account.sms.messages.create(
        :from => '6362340453',
        :to => self.data,
        :body => "We think this tweet has been hacked: #{tweet.body}"
      )
  end
end
