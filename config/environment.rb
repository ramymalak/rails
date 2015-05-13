# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!




#configure mailer settings
ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false


ActionMailer::Base.smtp_settings = {
  :address => 'smtp.gmail.com',
  :port => 587,
  #:domain => 'gmail.com',
  :user_name => 'yoyo80884@gmail.com',
  :password => 'yosrayosra',
  :authentication => :plain,
#  :enable_starttls_auto => false
}
