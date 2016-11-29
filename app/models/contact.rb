class Contact < ActiveRecord::Base
  belongs_to :category_enquiry
  belongs_to :category_contactclient
end
