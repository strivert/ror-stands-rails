# There is a default from address common to all mailers in the application
class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@example.com'
  layout 'mailer'
end
