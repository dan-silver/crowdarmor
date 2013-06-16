class Alert < ActiveRecord::Base
  belongs_to :user
  attr_accessible :action_type, :data, :threshold

  def launch(tweet)
    case self.action_type
    when 'SMS'
      puts 'Send an SMS about tweet.' 
      sendSMS tweet
    when 'Email'
      puts 'Send an email about tweet.'
    end
  end

  def self.valid_types
    [
      'SMS',
      'Email'
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
