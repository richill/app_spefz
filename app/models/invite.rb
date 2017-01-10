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

  def self.exists?(user, invitee)
    not find_by_user_id_and_invitee_id(user.id, invitee.id).nil?
  end

  def self.exists_test?(user, invitee, social)
    not find_by_user_id_and_invitee_id_and_social_id(user.id, invitee.id, social.id).nil?
  end
end

# this model represent invitations being sent by the creator of a social/event to other users

