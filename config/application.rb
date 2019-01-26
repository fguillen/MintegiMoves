require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups)
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module MintegiMoves
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true

    config.autoload_paths += %W(#{config.root}/lib)

    config.time_zone = "UTC"
    config.active_record.default_timezone = :utc

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es
    config.i18n.available_locales = [:en, :es]

    config.generators do |g|
      g.orm             :active_record
      g.test_framework  :test_unit, :fixture => false
      g.stylesheets     false
      g.helper          false
    end

    config.after_initialize do
      require "log_book/event"
    end
  end
end
