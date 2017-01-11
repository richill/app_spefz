class Invite < ActiveRecord::Base
  belongs_to :user
  belongs_to :social
  belongs_to :event
  belongs_to :invitee, class_name: "User", foreign_key: "invitee_id"

  has_and_belongs_to_many :users
  
  # validates_presence_of :user_id, :invitee_id

  scope :invitation_exist?, -> (user, social, other_user) { where(user_id: user.id, social_id: social.id, invitee_id: other_user.id) }
  # checks if invitation for current_user, other_user exist for a specific event
  # terminal: Invite.invitation_exist?(richill, social, richards).exists?

  scope :user_invited?, -> (social, other_user) { where(social_id: social).flat_map(&:users).include?(other_user) }
#   2.3.0 :018 >   Invite.user_invited?(social, other_user)
#   Invite Load (0.2ms)  SELECT "invites".* FROM "invites" WHERE "invites"."social_id" = 6
#   User Load (0.2ms)  SELECT "users".* FROM "users" INNER JOIN "invites_users" ON "users"."id" = "invites_users"."user_id" WHERE "invites_users"."invite_id" = ?  [["invite_id", 20]]
#   => true 
#   2.3.0 :019 > 

  def self.exists?(user, invitee)
    not find_by_user_id_and_invitee_id(user.id, invitee.id).nil?
  end
end

# this model represent invitations being sent by the creator of a social/event to other users

