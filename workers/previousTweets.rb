require "iron_mq"
require "twitter"

puts "Getting previous tweets..."
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