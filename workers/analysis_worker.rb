require "iron_mq"
require 'alchemy_api'
require 'json'

require 'uri'
require 'net/http'

AlchemyAPI.key = '8da86f0a977a22e600739f6f693b39fddefbd503'

search_keys = ['hack', 'fake', 'hoax']

ironmq = IronMQ::Client.new :token => "f29MgpP0JbVlnDJb0ii7Cmzkwg8", :project_id => "51bc92fd2267d85283001145"
queue = ironmq.queue "tweets"

begin
  if queue.size != 0

    puts
    puts 'Starting analysis of another tweet.'
    item = queue.get
    next if not item
    body = JSON.parse(item.body)
    text = body["text"]

    puts "Tweet: #{text}"
    begin
        results = AlchemyAPI.search(:keyword_extraction, :text => text)
        puts "Keyword results: #{results}"

        # convert string relevance to float
        results.map {|e| e['relevance'] = Float(e['relevance'])}

        # score is found keyword with max relevance that exists in search keys
        max = 0
        results.each do |r|
            if search_keys.include? r['text']
                max = r['relevance'] if r['relevance'] > max
            end
        end
        score = max

    puts "Score is: #{score}"
    rescue # blanket error handling for timeouts
        puts 'Caught a timeout exception.'
        score = 0
    end

    puts "Score is: #{score}"

    # bonus score if contains a search key
    search_keys.each do |key|
        if text.downcase.include? key
            score += 38 # lucky number for more accurate results
        end
    end

    score = 100 if score > 100

    puts "Score is: #{score}"

    uri = URI("http://www.crowdarmor.com/processed")
    #uri = URI("http://127.0.0.1:3000/processed")

    request = Net::HTTP::Post.new(uri.path)

    Net::HTTP.post_form(uri, {
        :Twitter_Handle => body['screen_name'],
        :score => score,
        :tweet_id => body['tweet_id'],
        :body => body['text']
    })

    item.delete
  end
  sleep(1)
end while not false