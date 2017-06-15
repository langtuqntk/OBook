class Comment < ApplicationRecord
  belongs_to :review_book
  belongs_to :user
end
