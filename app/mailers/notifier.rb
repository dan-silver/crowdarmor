class Notifier < ActionMailer::Base
  default :from => 'alert@crowdarmor.com'

  def alert_email(email, tweet)
    mail(:to => email, :subject => 'Crowd Armor Alert!',
      :body => "Alert!  Crowd Armor has detected a tweet that may be compromised:  #{tweet.body}")
  end
  
  # send a signup email to the user, pass in the user object that contains the user’s email address
  def signup_email(user)
    mail( :to => user.email,
    :subject => 'Thanks for signing up' )
  end
end
