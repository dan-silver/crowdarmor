require "iron_mq"
require 'alchemy_api'
require 'json'
AlchemyAPI.key = '8da86f0a977a22e600739f6f693b39fddefbd503'


ironmq = IronMQ::Client.new :token => "f29MgpP0JbVlnDJb0ii7Cmzkwg8", :project_id => "51bc92fd2267d85283001145"
queue = ironmq.queue "tweets"
begin
  if queue.size
    puts 'Starting run'
    item = queue.get
    body = JSON.parse(item.body)
    text = body["text"]
    puts "Tweet: #{text}"
    results = AlchemyAPI.search(:keyword_extraction, :text => text)
    puts results
    item.delete
    sleep(5)
  end
end while not false