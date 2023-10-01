def redis_url_with_default
  # Use the ENV['REDIS_URL'] if set, or provide a default value
  ENV['REDIS_URL'] || 'redis://localhost:6379/0'
end

# Configure Sidekiq with the Redis URL
Sidekiq.configure_client do |config|
  config.redis = { url: redis_url_with_default }
end

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url_with_default }
end
