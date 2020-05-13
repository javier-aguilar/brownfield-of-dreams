class UserActivationMailer < ApplicationMailer
  default :from => "no-reply@somedomain.com"
  layout 'mailer'

   def registration_confirmation(user)
      mail(:to => "#{user.name} <#{user.email}>", :subject => "Registration Confirmation")
   end
end
