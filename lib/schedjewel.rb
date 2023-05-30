# frozen_string_literal: true

require 'logger'
require 'memo_wise'
require 'redis-client'
require 'yaml'

# rubocop:disable Lint/EmptyClass
class Schedjewel; end
# rubocop:enable Lint/EmptyClass

Dir["#{File.dirname(__FILE__)}/schedjewel/*.rb"].each { |file| require file }

class Schedjewel
  class << self
    prepend MemoWise

    memo_wise \
    def logger
      Logger.new($stdout).tap do |logger|
        logger.formatter = ->(_severity, _datetime, _progname, msg) { "#{msg}\n" }
        logger.level = Logger::INFO
      end
    end

    memo_wise \
    def app_redis
      RedisClient.new(url: "#{config.redis_url}/#{config.app_redis_db}")
    end

    memo_wise \
    def sidekiq_redis
      RedisClient.new(url: "#{config.redis_url}/#{config.sidekiq_redis_db}")
    end

    memo_wise \
    def config
      Schedjewel::Config.new(parsed_config_file['config'] || {})
    end

    memo_wise \
    def parsed_config_file
      YAML.load(ERB.new(File.read('config/schedjewel.yml')).result)
    end
  end
end
