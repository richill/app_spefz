class InviteRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :social
  belongs_to :event
  belongs_to :inviter, class_name: "User", foreign_key: "inviter_id"
  validates_presence_of :user_id, :inviter_id

  scope :invitation_request_exist?, -> (user, social, event_organizer) { where(user_id: user.id, social_id: social.id, inviter_id: event_organizer.id) }
  # checks if invitation request for current_user, other_user exist for a specific event/social
  # terminal: Invite.invitation_exist?(richill, social, richards).exists?
end
