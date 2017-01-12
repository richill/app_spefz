module InvitesHelper
  def sociallist_for(inviter, invitee)
    socials = Set.new(Social.live_socials.open_socials.where(user: inviter).to_a)
    sent_socials = Set.new(Invite.where(user: inviter, invitee: invitee).to_a.map(&:social))
    socials.difference(sent_socials)
  end
end


# module InvitesHelper
#   def sociallist_for(inviter, invitee)
#     socials = Set.new(Social.live_socials.open_socials.where(user: inviter).to_a)
#     sent_socials = Set.new(Invite.where(user: inviter, invitee: invitee).to_a.map(&:social))
#     socials.difference(sent_socials)

#     #my_created_socials = list socials
#     #my_socials_my_friend_richard_has_been_invited_to = list socials
#     #my_socials_my_friend_richard_has_not_yet_been_invited_to = my_created_socials.difference(my_socials_my_friend_richard_has_been_invited_to)

#   end
# end

#aim: finding my socials that the user(richard) has already been invited to

#Invite.where(user: richill, social_id: social).flat_map(&:users)
#Invite.where(user: richill, invitee: nil).map(&:social)
#Invite.where(user: richill, invitee: invitee).map(&:social) = show social i have invited richard to
#ap Invite.joins(:users).uniq