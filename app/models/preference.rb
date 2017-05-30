class Preference < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_preferences, use: :slugged

  belongs_to :user
  before_create :preference_name

  belongs_to :category_idealrelationship, dependent: :destroy
  

  belongs_to :category_matchseeking, dependent: :destroy
  belongs_to :category_matchrelationship, dependent: :destroy
  belongs_to :category_matchstatus, dependent: :destroy
  belongs_to :category_matchparent, dependent: :destroy
  belongs_to :category_matchkid, dependent: :destroy
  belongs_to :category_matcheducation, dependent: :destroy
  belongs_to :category_matchheight, dependent: :destroy
  belongs_to :category_matchbodytype, dependent: :destroy
  belongs_to :category_matchethnicity, dependent: :destroy
  belongs_to :category_matchreligion, dependent: :destroy
  belongs_to :category_matchsmoke, dependent: :destroy



  def slug_preferences
    [
      :name
    ]
  end

  def preference_name
    self.name = "match_type"
  end
end
