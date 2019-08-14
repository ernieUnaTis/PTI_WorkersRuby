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
		response = Net::HTTP.get_response('localhost', '/productores?shortcode=3000&id=123456&msisdn=54123456789&carrier=ar.movistar&tipo=sms_mt&cobro=SC',3000)
		puts response.code
	end


end
