class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.dig(:action_mailer, :user),
  layout 'mailer'
end
