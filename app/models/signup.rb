class Signup < ActiveRecord::Base
  validates_presence_of :name, presence: true, message: "can't be blank"
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "can't be blank or invalid format" }
end
