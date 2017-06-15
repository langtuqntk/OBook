class Book < ApplicationRecord
  has_and_belongs_to_many :category

  has_many :user_book
  has_many :user, through: :user_book

  has_many :rating_book
  has_many :user, through: :rating_book

  has_many :review_book
  has_many :user, through: :review_book
end
