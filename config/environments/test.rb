MintegiMoves::Application.configure do
  config.cache_classes = true
  config.serve_static_files = true
  config.static_cache_control = "public, max-age=3600"
  config.whiny_nils = true
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = false
  config.action_controller.allow_forgery_protection    = false
  config.action_mailer.delivery_method = :test
  config.active_support.deprecation = :stderr

  config.eager_load = false
  config.active_support.test_order = :sorted
  config.active_record.raise_in_transactional_callbacks = true
  config.action_mailer.delivery_method = :test
end
