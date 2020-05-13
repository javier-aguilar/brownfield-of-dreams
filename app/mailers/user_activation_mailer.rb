class UserActivationMailer < ApplicationMailer
  # default :from => "no-reply@somedomain.com"
  # layout 'mailer'

  def registration_confirmation(user)
    @user = user
    @user_name = @user.first_name + " " + @user.last_name
    @user_email = user.email
    mail(:to => "#{@user_name} <#{@user_email}>", :subject => "Brownfield Registration Confirmation")
  end
end
