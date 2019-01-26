MintegiMoves::Application.configure do
  config.cache_classes = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.serve_static_files = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify

  # lograge
  config.lograge.enabled = true

  config.eager_load = true
  config.active_record.raise_in_transactional_callbacks = true
  config.action_mailer.delivery_method = :smtp
  config.log_level = :info
  config.assets.enabled = false
  config.serve_static_files = true
end
