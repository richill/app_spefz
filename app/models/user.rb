class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_taggable

  belongs_to :category_gender 
  has_many :events, dependent: :destroy
  has_many :socials, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :favourite_socials, through: :favourites, source: :favourited, source_type: 'Social', dependent: :destroy
  has_many :favourite_events, through: :favourites, source: :favourited, source_type: 'Event', dependent: :destroy

  has_many :attendances, dependent: :destroy
  has_many :attending_socials, through: :attendances, source: :attendable, source_type: 'Social', dependent: :destroy

  # acts_as_commentable
  has_many :comments, as: :commentable, dependent: :destroy

  #users main_user is following / main_user here is follower_id - main_user is the followed_id
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  
  #users following main_user / main_user here is followed_id - other_user is the follower_id
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  #users main_user has sent frienship_request / main_user here is friender_id - main_user is the friended_id
  has_many :active_friendship_requests, class_name: "Friendship", foreign_key: "friender_id", dependent: :destroy
  has_many :sent_friend_requests, through: :active_friendship_requests, source: :friended

  #users sending friend_requests to main_user / main_user here is friended_id - other_user is the friender_id
  has_many :passive_friendship_requests, class_name: "Friendship", foreign_key: "friended_id", dependent: :destroy
  has_many :received_friend_requests, through: :passive_friendship_requests, source: :friender

  mount_uploader :image, ImageUploader

  #follow a user
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  #unfollow a user
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  #returns true if user is following a user
  def following?(other_user)
    followings.include?(other_user)
  end

  #friend a user (by sending a friend_request)
  def friend(other_user)
    active_friendship_requests.create(friended_id: other_user.id)
  end

  #unfriend a user (by cancelling friend_request)
  def unfriend(other_user)
    active_friendship_requests.find_by(friended_id: other_user.id).destroy
  end
  
  #returns true if user has sent a friend request
  def friended?(other_user)
    sent_friend_requests.include?(other_user)
  end

  def self.desc_order
    order('created_at DESC')
  end

  #checks if current user is attending social
  # def current_user_attending?(social)
  #   self.socials.exists?(social: social)
  # end
end

