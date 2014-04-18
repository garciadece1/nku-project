class ModelMailer < ActionMailer::Base
  default from: "noreply@docloud.co"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.new_record_notification.subject
  #

  def request_email_verification(verification)
    @verification = verification
    mail to: verification.user.email, subject: "Please verify your email address on docloud.co"
  end
end
