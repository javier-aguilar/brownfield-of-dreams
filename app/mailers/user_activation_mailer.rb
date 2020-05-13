class UserActivationMailer < ApplicationMailer
  default :from => "no-reply@somedomain.com"
  layout 'mailer'

  def registration_confirmation(user)
    user_name = user.first_name + " " + user.last_name
    mail(:to => "#{user_name} <#{user.email}>", :subject => "Brownfield Registration Confirmation")
  end
end
