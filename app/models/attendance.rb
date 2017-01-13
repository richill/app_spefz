class Attendance < ActiveRecord::Base
  include PublicActivity::Model
  tracked only: [:create], owner: -> (controller, model) { controller && controller.current_user }

  belongs_to :user
  belongs_to :attendable, polymorphic: true

  scope :female_attendance, -> { joins(user: :category_gender).where('category_genders.name' => "Female") }
  scope :male_attendance, -> { joins(user: :category_gender).where('category_genders.name' => "Male") }
end
