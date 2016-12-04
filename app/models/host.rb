class Host < ActiveRecord::Base
  # has_many :users
  # belongs_to :user #add user_id under hosts
  # has_and_belongs_to_many :users

  has_many :users 
  #remove user_id under hosts

  belongs_to :event
end
