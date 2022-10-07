# frozen_string_literal: true

require 'logger'
require 'memoist'
require 'redis'
require 'yaml'

# rubocop:disable Lint/EmptyClass
class Schedjewel; end
# rubocop:enable Lint/EmptyClass

Dir["#{File.dirname(__FILE__)}/schedjewel/*.rb"].each { |file| require file }

class Schedjewel
  class << self
    extend Memoist

    memoize \
    def logger
      Logger.new($stdout).tap do |logger|
        logger.formatter = ->(_severity, _datetime, _progname, msg) { "#{msg}\n" }
        logger.level = Logger::INFO
      end
    end

    memoize \
    def sidekiq_redis
      # Our Sidekiq setup uses Redis database number 1 (see config/initializers/sidekiq.rb).
      # We are using `redis` rather than `redis-client` because `redlock` (which we are already
      # using for locking) uses `redis`.
      Redis.new(url: "#{ENV.fetch('REDIS_URL', 'redis://localhost:6379')}/1")
    end
  end
end
