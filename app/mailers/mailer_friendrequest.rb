class MailerFriendrequest < ApplicationMailer
  def friend_request(user, friend)
    @user = user
    @friend = friend
    mail( to: "#{friend.email}", 
          subject: "Spefz | Connect Request", 
          from: "<no-reply@spefz.com>")
  end
end
