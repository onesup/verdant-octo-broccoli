redis_config = YAML.load_file(Rails.root.to_s + '/config/redis.yml')

Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{redis_config[Rails.env]}", namespace: 'sidekiq' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{redis_config[Rails.env]}", namespace: 'sidekiq' }
end
