class UserActivity < ApplicationRecord
  belongs_to :user
  belongs_to :activity

  has_many :like_activity
  has_many :user, through: :like_activity
end
