require "iron_mq"
require 'alchemy_api'
require 'json'

require 'uri'
require 'net/http'

AlchemyAPI.key = '8da86f0a977a22e600739f6f693b39fddefbd503'

searchKeys = ['hack', 'fake', "hacked"]

ironmq = IronMQ::Client.new :token => "f29MgpP0JbVlnDJb0ii7Cmzkwg8", :project_id => "51bc92fd2267d85283001145"
queue = ironmq.queue "tweets"
begin
  if queue.size
    puts 'Starting analysis'
    item = queue.get
    body = JSON.parse(item.body)
    text = body["text"]
    puts "Tweet: #{text}"
    results = AlchemyAPI.search(:keyword_extraction, :text => text)
    keywords = results.map {|n| n["text"]}
    puts "Keywords: "
    puts keywords
    matches = keywords & searchKeys
    puts "Found keywords"
    puts matches || "None"
    #uri = URI("http://www.crowdarmor.com/processed")
    uri = URI("http://127.0.0.1:3000/processed")
    https = Net::HTTP.new(uri.host, uri.port)

    request = Net::HTTP::Post.new(uri.path)

    request["score"] = matches.length
    request["tweet_id"] = body['tweet_id']
    
    request["body"] = text
    request["Twitter_Handle"] = body['screen_name']

    response = https.request(request)
    item.delete
  end
  sleep(10)
end while not false