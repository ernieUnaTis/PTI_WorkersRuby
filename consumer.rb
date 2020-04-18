require 'sidekiq'
require 'net/http'
require 'kafka'
require 'redis'

# We'll configure the Sidekiq client to connect to Redis using a custom
# DB - this way we can run multiple apps on the same Redis without them
# stepping on each other

Sidekiq.configure_client do |config|
  config.redis = { url:'redis://localhost:6379' }
end

# We'll configure the Sidekiq server as well

Sidekiq.configure_server do |config|
  config.redis = { url:'redis://localhost:6379' }
end


class SmsWorker
    include Sidekiq::Worker

    def perform()
          loop do
            puts "Ernesto"
            #Desencolar de Redis
            redis = Redis.new
            queue = Redis::Queue.new('q_test_mensajeria','bp_q_test',  :redis => redis)
            queue.process(false, 30) do |message|
              puts "'#{message}'"
            end





                      #Encolar en Kafka
                      #logger = Logger.new($stderr)
                      #brokers = ENV.fetch("KAFKA_BROKERS")
                      #topic = "smsRuby"
                      #kafka = Kafka.new(
                      #  seed_brokers: brokers,
                      #  client_id: "simple-producer",
                      #  logger: logger,
                      #  )
                      #  producer = kafka.producer
                      #  begin
                      #    producer.produce(message, topic: topic)
                      #  end

          end
    end
end
