class Host < ActiveRecord::Base
  # belongs_to :user #add user_id under hosts

  has_many :users 
  #remove user_id under hosts

  belongs_to :event
end
