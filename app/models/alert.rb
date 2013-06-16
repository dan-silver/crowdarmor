class Alert < ActiveRecord::Base
  belongs_to :user
  attr_accessible :action_type, :data, :threshold

  def launch(tweet)
    case self.action_type
    when 'SMS'
      puts 'Send an SMS about tweet.' 
    when 'Email'
      Notifier.alert_email(self.data, tweet).deliver
    end
  end

  def self.valid_types
    [
      'SMS',
      'Email'
    ]
  end
end
