class Preference < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_preferences, use: :slugged

  validates_presence_of :category_idealrelationship, presence: true, message: "can't be blank"
  validates_presence_of :category_idealparent, presence: true, message: "can't be blank"
  validates_presence_of :category_idealkid, presence: true, message: "can't be blank"
  validates_presence_of :category_idealstatus, presence: true, message: "can't be blank"
  validates_presence_of :category_idealeducation, presence: true, message: "can't be blank"
  validates_presence_of :category_idealheight, presence: true, message: "can't be blank"
  validates_presence_of :category_idealbodytype, presence: true, message: "can't be blank"
  validates_presence_of :category_idealethnicity, presence: true, message: "can't be blank"
  validates_presence_of :category_idealreligion, presence: true, message: "can't be blank"
  validates_presence_of :category_idealsmoke, presence: true, message: "can't be blank"

  validates_presence_of :category_matchseeking, presence: true, message: "can't be blank"
  validates_presence_of :category_matchrelationship, presence: true, message: "can't be blank"
  validates_presence_of :category_matchstatus, presence: true, message: "can't be blank"
  validates_presence_of :category_matchparent, presence: true, message: "can't be blank"
  validates_presence_of :category_matchkid, presence: true, message: "can't be blank"
  validates_presence_of :category_matcheducation, presence: true, message: "can't be blank"
  validates_presence_of :category_matchheight, presence: true, message: "can't be blank"
  validates_presence_of :category_matchbodytype, presence: true, message: "can't be blank"
  validates_presence_of :category_matchethnicity, presence: true, message: "can't be blank"
  validates_presence_of :category_matchreligion, presence: true, message: "can't be blank"
  validates_presence_of :category_matchsmoke, presence: true, message: "can't be blank"
  validate :idealage_start_end

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

  def idealage_start_end
    if idealage_start.blank? && idealage_end.blank?
      errors.add(:idealage_start, "can't be blank")
      errors.add(:idealage_end, "can't be blank")
    end
  end
end
