class Report < ActiveRecord::Base
  belongs_to :category_report
  belongs_to :social
end
