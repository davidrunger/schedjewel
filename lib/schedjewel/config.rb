# frozen_string_literal: true

class Schedjewel::Config
  extend Memoist

  def initialize(config_hash)
    @config_hash = config_hash
  end

  memoize \
  def redis_url
    ENV.fetch('REDIS_URL', 'redis://localhost:6379')
  end

  memoize \
  def app_redis_db
    @config_hash['app_redis_db'] || 0
  end

  memoize \
  def sidekiq_redis_db
    @config_hash['sidekiq_redis_db'] || 0
  end
end
