class MailerConnectrequest < ApplicationMailer
  def connectrequest(user, friend)
    @user = user
    @friend = friend
    mail( to: "#{friend.email}", 
          subject: "Spefz | Connect Request", 
          from: "<no-reply@spefz.com>")
  end
end
