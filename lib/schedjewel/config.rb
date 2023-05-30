# frozen_string_literal: true

class Schedjewel::Config
  prepend MemoWise

  def initialize(config_hash)
    @config_hash = config_hash
  end

  memo_wise \
  def redis_url
    ENV.fetch('REDIS_URL', 'redis://localhost:6379')
  end

  memo_wise \
  def app_redis_db
    @config_hash['app_redis_db'] || 0
  end

  memo_wise \
  def sidekiq_redis_db
    @config_hash['sidekiq_redis_db'] || 0
  end
end
