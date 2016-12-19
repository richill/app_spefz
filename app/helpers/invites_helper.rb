module InvitesHelper
  def sociallist_for(inviter, invitee)
    socials = Set.new(Social.where(user: inviter).to_a)
    sent_socials = Set.new(Invite.where(user: inviter, invitee: invitee).to_a.map(&:social))
    socials.difference(sent_socials)
  end
end
