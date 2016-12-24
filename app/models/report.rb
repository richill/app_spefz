class Report < ActiveRecord::Base
  belongs_to :category_report
  belongs_to :social
  belongs_to :event
  belongs_to :user
end
