class MailerInvitemember < ApplicationMailer
  def invitation(user, friend)
    @user = user
    @friend = friend
    mail( to: "#{friend.email}", 
          subject: "Spefz | Private Invite to New Members Night Out (West London)", 
          from: "<no-reply@spefz.com>")
  end
end
