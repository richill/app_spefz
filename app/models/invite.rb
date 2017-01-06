class Invite < ActiveRecord::Base
  belongs_to :user
  belongs_to :social
  belongs_to :event
  belongs_to :invitee, class_name: "User", foreign_key: "invitee_id"
  validates_presence_of :user_id, :invitee_id

  scope :invited?, -> (user, social) { where(user_id: user.id, social_id: social.id) }

  def self.exists?(user, invitee)
    not find_by_user_id_and_invitee_id(user.id, invitee.id).nil?
  end
end




