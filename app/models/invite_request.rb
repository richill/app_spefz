class InviteRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :social
  belongs_to :event
  belongs_to :inviter, class_name: "User", foreign_key: "inviter_id"
  validates_presence_of :user_id, :inviter_id
end
