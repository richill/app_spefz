class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :attendable, polymorphic: true

  scope :female_attendance, -> { joins(user: :category_gender).where('category_genders.name' => "Female") }
  scope :male_attendance, -> { joins(user: :category_gender).where('category_genders.name' => "Male") }
end
