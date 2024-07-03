class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :habit
  validates :comment, presence: true
end
