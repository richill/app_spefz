class Host < ActiveRecord::Base
  validates_presence_of :user_ids, presence: true
  has_and_belongs_to_many :users 
  belongs_to :event
end
