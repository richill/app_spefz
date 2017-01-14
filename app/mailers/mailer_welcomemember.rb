class MailerWelcomemember < ActionMailer::Base
  def welcome_member(user)
    @user = user
    mail( to: "#{user.email}", 
          subject: "Spefz | Welcome to SPefz!", 
          from: "<no-reply@spefz.com>")
  end
end