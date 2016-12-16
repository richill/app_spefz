class Friendship < ActiveRecord::Base
  belongs_to :User
  belongs_to :friend, class_name: "User", foreign_key: "friend_id"
  validates_presence_of :user_id, :friend_id

  belongs_to :friender, class_name: "User"
  belongs_to :friended, class_name: "User"
  validates :friender_id, presence: true
  validates :friended_id, presence: true
end


