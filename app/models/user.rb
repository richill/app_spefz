class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :category_gender 
  has_many :events, dependent: :destroy
  has_many :socials, dependent: :destroy

  #active_relationships focuses on the activity/relationship of the main_user (follower_id) - who the main user is following
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  
  #passive_relationships focuses on the activity/relationship of the other_user (followed_id) - users is following the main user
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  mount_uploader :image, ImageUploader

  #follow a user
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  #unfollow a user
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  #returns true is user is following a user
  def following?(other_user)
    following.include?(other_user)
  end
end

