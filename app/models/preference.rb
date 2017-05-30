class Preference < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_preferences, use: :slugged

  belongs_to :user
  before_create :preference_name

  belongs_to :category_matchseeking, dependent: :destroy

  def slug_preferences
    [
      :name
    ]
  end

  def preference_name
    self.name = "match_type"
  end
end
