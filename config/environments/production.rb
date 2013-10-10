MintegiMoves::Application.configure do
  config.cache_classes = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify

  # lograge
  config.lograge.enabled = true
end
