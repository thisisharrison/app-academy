class UserMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def activation_email(user)
    @user = user 
    mail(to: user.email, subject: "Welcome to Music App! Start today!")
  end

end
