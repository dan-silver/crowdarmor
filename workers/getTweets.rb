puts 'Starting up getTweets Worker...'


require "tweetstream"
require "iron_mq"
require 'json'

TweetStream.configure do |config|
  config.consumer_key       = "d97mHG7MRvESV0cIs2gMbg"
  config.consumer_secret    = "V1apx1fjO0ynLYZzcW9s3xff3l0ifI3kTmZqV59zng"
  config.oauth_token        = "1519626841-AOn8G3h9NyxsEQELHmIGW9phit1J7Ph2oXRZaQT"
  config.oauth_token_secret = "656QqQgMJKaNcRju5roHCJKpqo4kDIcMp4Gn0kw0uE"
  config.auth_method        = :oauth
end
ironmq = IronMQ::Client.new :token => "f29MgpP0JbVlnDJb0ii7Cmzkwg8", :project_id => "51bc92fd2267d85283001145"
queue = ironmq.queue "tweets"

puts "Received params:"
puts params
puts
params = params || {:handles => ['BarackObama']} # for local testing
handles = params[:handles]
handles_with_at = handles.map {|h| '@' + h}
puts 'Streaming the following twitter handles:'
puts handles
puts

@client = TweetStream::Client.new
@client.track(handles_with_at) do |status|
  puts
  puts 'Processing new tweet'
  screen_names = status.user_mentions.collect(&:screen_name)
  cur_name = handles & screen_names # get array intersection
  if cur_name.any?
    message = {:screen_name => cur_name.first, :text => status.text}.to_json
    puts message
    queue.post(message)
  else
    puts "Error:  Didn't find screen name in a tweet."
  end
end

puts 'Reached end of Twitter stream.  Is that even possible???'
