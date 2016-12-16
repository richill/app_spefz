class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User", foreign_key: "friend_id"
  validates_presence_of :user_id, :friend_id

  # belongs_to :friender, class_name: "User"
  # belongs_to :friended, class_name: "User"
  # validates :friender_id, presence: true
  # validates :friended_id, presence: true


  # Return true if the users are (possibly pending) friends.
  def self.exists?(user, friend)
    not find_by_user_id_and_friend_id(user.id, friend.id).nil?
  end

  # Record a pending friend request.
  def self.request(user, friend)
    unless user == friend or Friendship.exists?(user, friend)
      transaction do
        create(user: user, friend: friend, status: 'pending')
        create(user: friend, friend: user, status: 'requested')
      end
    end 
  end

  # Accept a friend request
  def self.accept(user, friend)
    transaction do
      accepted_at = Time.now
      accept_one_side(user, friend, accepted_at)
      accept_one_side(friend, user, accepted_at)
    end
  end

  # Delete a friendship or cancel a pending request.
  def self.breakup(user, friend)
    transaction do
      destroy(find_by_user_id_and_friend_id(user.id, friend.id))
      destroy(find_by_user_id_and_friend_id(friend.id, user.id))
    end 
  end

  private

  # Update the db with one side of an accepted friendship request.
  def self.accept_one_side(user, friend, accepted_at)
    request = find_by_user_id_and_friend_id(user.id, friend.id)
    request.status = 'accepted'
    request.accepted_at = accepted_at
    request.save!
  end
end


