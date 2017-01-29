class Comment < ActiveRecord::Base
  include ActsAsCommentable::Comment

  validates_presence_of :content, presence: true, message: "can't be blank"
  belongs_to :commentable, polymorphic: true

  default_scope -> { order('created_at DESC') }

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user
  belongs_to :social
end


