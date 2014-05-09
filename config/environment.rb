# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Ocd::Application.initialize!

config.action_mailer.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address         => "smtp.sendgrid.net",
  :port            => "587",
  :user_name       => ENV["SENDGRID_USERNAME"],
  :password        => ENV["SENDGRID_PASSWORD"],
  :domain          => "heroku.com",
  :authentication  => :plain,
  :enable_starttls_auto => true
}
