class UserMailer < ApplicationMailer
    default from: 'ninetyninecatsadmin@99cats.com'

    def welcome_email(user)
        @user = user 
        @url = new_session_url
        mail(to: user.username, subject: 'Welcome to 99 cats!')
    end
end
