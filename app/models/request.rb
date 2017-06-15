class Request < ApplicationRecord
  belongs_to :user
  validates :title, :contenthtml, presence: true
end
