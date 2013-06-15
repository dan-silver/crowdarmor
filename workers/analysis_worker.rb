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
  if queue.size != 0
    puts 'Starting analysis'
    item = queue.get
    body = JSON.parse(item.body)
    text = body["text"]
    puts "Tweet: #{text}"
#    results = AlchemyAPI.search(:keyword_extraction, :text => text)
#    keywords = results.map {|n| n["text"]}
#    puts "Keywords: "
#    puts keywords
#    matches = keywords & searchKeys
    puts "Found keywords"
#    puts matches || "None"

    #uri = URI("http://www.crowdarmor.com/processed")
    uri = URI("http://127.0.0.1:3000/processed")

    request = Net::HTTP::Post.new(uri.path)

    Net::HTTP.post_form(uri, {
        :Twitter_Handle => body['screen_name'],
        :score => 0,
        :tweet_id => body['tweet_id'],
        :body => body['text']
        })

    item.delete
  end
  sleep(10)
end while not false