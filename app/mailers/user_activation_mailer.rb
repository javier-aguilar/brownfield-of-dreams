class UserActivationMailer < ApplicationMailer
  default :from => "us@somedomain.com"

   def registration_confirmation(user)
      mail(:to => "#{user.name} <#{user.email}>", :subject => "Registration Confirmation")
   end
end
