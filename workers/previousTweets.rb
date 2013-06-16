require "iron_mq"
require "twitter"

Twitter.configure do |config|
  config.consumer_key = "d97mHG7MRvESV0cIs2gMbg"
  config.consumer_secret = "V1apx1fjO0ynLYZzcW9s3xff3l0ifI3kTmZqV59zng"
  config.oauth_token = "1519626841-AOn8G3h9NyxsEQELHmIGW9phit1J7Ph2oXRZaQT"
  config.oauth_token_secret = "656QqQgMJKaNcRju5roHCJKpqo4kDIcMp4Gn0kw0uE"
end

puts "Getting previous tweets..."
params ={"Token"=>"1519626841-AOn8G3h9NyxsEQELHmIGW9phit1J7Ph2oXRZaQT", "TokenSecret"=>"656QqQgMJKaNcRju5roHCJKpqo4kDIcMp4Gn0kw0uE", "Twitter_Handle"=>"crowdarmor"}
puts params
ironmq = IronMQ::Client.new :token => "f29MgpP0JbVlnDJb0ii7Cmzkwg8", :project_id => "51bc92fd2267d85283001145"
@@queue = ironmq.queue "tweets"


@client = Twitter::Client.new(
  :oauth_token => params['Token'],
  :oauth_token_secret => params['TokenSecret']
)
tweets = @client.mentions_timeline.each do |status|
  if params['Twitter_Handle'] == status.in_reply_to_screen_name and status.in_reply_to_status_id # gonna process it
    message = {
      :screen_name => status.in_reply_to_screen_name,
      :text => status.text,
      :tweet_id => status.in_reply_to_status_id
    }.to_json
    puts message
    @@queue.post message
  end
end