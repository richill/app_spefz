ActionMailer::Base.smtp_settings = {
  address: "smtp.sparkpostmail.com",
  port: 587,
  enable_starttls_auto: true,
  user_name: "SMTP_Injection",
  password: Rails.application.secrets.sparkpost_api_key,
  authentication: :login
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: "utf-8"