if APP_CONFIG[:smtp]["enabled"]
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.delivery_method = :smtp

  ActionMailer::Base.smtp_settings = {
    :address => APP_CONFIG[:smtp]["server"],
    :port => APP_CONFIG[:smtp]["port"],
    :domain => APP_CONFIG[:smtp]["domain"],
    :user_name => APP_CONFIG[:smtp]["user"],
    :password => APP_CONFIG[:smtp]["pass"],
    :authentication => "plain",
    :enable_starttls_auto => true
  }
end