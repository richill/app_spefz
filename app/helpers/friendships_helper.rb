module FriendshipsHelper
  # Return an appropriate friendship status message.
  def friendship_status(user, friend)
    friendship = Friendship.find_by_user_id_and_friend_id(user.id, friend.id)
    return "#{friend.firstname} is not in your network (yet)" if friendship.nil?
    case friendship.status
    when 'requested'
      "#{friend.firstname} wants to connect with you"
    when 'pending'
      "You have requested to connect with #{friend.firstname}"
    when 'accepted'
      "#{friend.firstname} is in your network"
    end
  end
end
