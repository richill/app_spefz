class Preference < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_preferences, use: :slugged

  belongs_to :user
  before_create :preference_name

  belongs_to :category_idealrelationship, dependent: :destroy
  belongs_to :category_idealparent, dependent: :destroy
  belongs_to :category_idealkid, dependent: :destroy
  has_and_belongs_to_many :category_idealstatus, dependent: :destroy
  has_and_belongs_to_many :category_idealeducation, dependent: :destroy
  has_and_belongs_to_many :category_idealheight, dependent: :destroy
  has_and_belongs_to_many :category_idealbodytype, dependent: :destroy
  has_and_belongs_to_many :category_idealethnicity, dependent: :destroy
  has_and_belongs_to_many :category_idealreligion, dependent: :destroy
  has_and_belongs_to_many :category_idealsmoke, dependent: :destroy

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
