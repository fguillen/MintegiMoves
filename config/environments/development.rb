MintegiMoves::Application.configure do
  config.cache_classes = false
  config.whiny_nils = true
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.active_support.deprecation = :log
  config.action_dispatch.best_standards_support = :builtin

  # lograge
  config.lograge.enabled = false

  config.eager_load = false
  config.active_record.raise_in_transactional_callbacks = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = false
  config.action_mailer.raise_delivery_errors = true
end
