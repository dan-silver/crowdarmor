class Alert < ActiveRecord::Base
  belongs_to :user
  attr_accessible :action_type, :data, :threshold

  def send(tweet)
    case self.action_type
    when 'SMS'
      puts 'Send an SMS about tweet.' 
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
end
