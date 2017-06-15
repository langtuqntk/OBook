class ReviewBook < ApplicationRecord
#  belongs_to :user
  belongs_to :book

  has_many :comment
  has_many :user, through: :comment

end
