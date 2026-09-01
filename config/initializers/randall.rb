# Host for the ack magic-links baked into reminders, and SMTP for the Email channel.
host = ENV.fetch("APP_HOST", "localhost:3000")
Rails.application.routes.default_url_options[:host] = host
Rails.application.config.action_mailer.default_url_options = { host: host }
Rails.application.config.action_mailer.delivery_method = :smtp

if ENV["SMTP_ADDRESS"].present?
  Rails.application.config.action_mailer.smtp_settings = {
    address:              ENV["SMTP_ADDRESS"],
    port:                 ENV.fetch("SMTP_PORT", 587).to_i,
    user_name:            ENV["SMTP_USERNAME"],
    password:             ENV["SMTP_PASSWORD"],
    authentication:       :plain,
    enable_starttls_auto: true
  }
end
