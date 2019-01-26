if Rails.env.production?
  Rails.application.config.middleware.use(
    ExceptionNotification::Rack,
    :email => {
      :email_prefix => "[MintegiMoves] ",
      :sender_address => '"Fernando Guillen" <fguillen.mail@gmail.com>',
      :exception_recipients => "fguillen.mail@gmail.com"
    }
  )
end
