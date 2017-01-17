class MailerReport < ApplicationMailer
  def report_content(user)
    @user = user
    mail( to: "#{user.email}", 
          subject: "Spefz | Welcome to SPefz!", 
          from: "<no-reply@spefz.com>")
  end
end
