class ApplicationMailer < ActionMailer::Base
  append_view_path Rails.root.join('app', 'views', 'mailers') # Place mailer views inside of app/views/mailers
  default from: ENV['MAILER_SENDER']
  layout "mailer"
end
