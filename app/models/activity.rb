class Activity < ApplicationRecord
  has_many :user_activity
  has_many :user, through: :user_activity
end
