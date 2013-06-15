'''
require "tweetstream"
#require "iron_mq"
TweetStream.configure do |config|
  config.consumer_key       = "d97mHG7MRvESV0cIs2gMbg"
  config.consumer_secret    = "V1apx1fjO0ynLYZzcW9s3xff3l0ifI3kTmZqV59zng"
  config.oauth_token        = "1519626841-AOn8G3h9NyxsEQELHmIGW9phit1J7Ph2oXRZaQT"
  config.oauth_token_secret = "656QqQgMJKaNcRju5roHCJKpqo4kDIcMp4Gn0kw0uE"
  config.auth_method        = :oauth
end
#ironmq = IronMQ::Client.new :token => "f29MgpP0JbVlnDJb0ii7Cmzkwg8", :project_id => "51bc92fd2267d85283001145"
#queue = ironmq.queue "tweets"
@client = TweetStream::Client.new
@client.track("obama", "potus") do |status|
#  queue.post status.text
  puts status.text
  puts "tweet"
end
'''
puts "I got '#{params}' parameters"
#puts "#{params.foo}"
puts params[:foo]