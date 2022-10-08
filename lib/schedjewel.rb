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
    def app_redis
      Redis.new(url: "#{config.redis_url}/#{config.app_redis_db}")
    end

    memoize \
    def sidekiq_redis
      Redis.new(url: "#{config.redis_url}/#{config.sidekiq_redis_db}")
    end

    memoize \
    def config
      Schedjewel::Config.new(parsed_config_file['config'] || {})
    end

    memoize \
    def parsed_config_file
      YAML.load(ERB.new(File.read('config/schedjewel.yml')).result)
    end
  end
end
