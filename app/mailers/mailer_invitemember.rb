class MailerInvitemember < ApplicationMailer
  def invitememeber(invite)
    @invite = invite
    mail( to: "#{invite.invitee.email}", 
          subject: "Spefz | Private Invite to #{invite.social.title}", 
          from: "<no-reply@spefz.com>")
  end
end
