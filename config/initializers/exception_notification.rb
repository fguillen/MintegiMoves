if Rails.env.production? || Rails.env.staging?
  MintegiMoves::Application.config.middleware.use(
    ExceptionNotifier,
    :email_prefix => "[MintegiMoves] ",
    :sender_address => APP_CONFIG[:admin_email],
    :exception_recipients => [APP_CONFIG[:admin_email]]
  )
end
