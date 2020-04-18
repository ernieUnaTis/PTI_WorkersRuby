require 'sidekiq'
require 'net/http'

# We'll configure the Sidekiq client to connect to Redis using a custom
# DB - this way we can run multiple apps on the same Redis without them
# stepping on each other

Sidekiq.configure_client do |config|
  config.redis = { db: 1 }
end

# We'll configure the Sidekiq server as well

Sidekiq.configure_server do |config|
  config.redis = { db: 1 }
end


class SmsWorker
	include Sidekiq::Worker

	def perform()
    $i = 1
    while $i > 0  do
		    response = Net::HTTP.get_response('127.0.0.1', '/productores?shortcode=3000&id=123456&msisdn=54123456789&carrier=ar.movistar&tipo=sms_mt&cobro=SC',3000)
        #if(response.code==200)
          puts "Encolamiento correcto " + response.code + "__" + response.message
        #end
        sleep 5
    end
	end


end
