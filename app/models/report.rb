class Report < ActiveRecord::Base
  belongs_to :category_report
  has_many :socials
end
