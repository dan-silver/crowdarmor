require "iron_worker_ng"
client = IronWorkerNG::Client.new
5.times do
   client.tasks.create("getTweets", "foo"=>"bar", "another"=>"test")
end