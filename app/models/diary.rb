class Diary < ApplicationRecord
  has_one :habit
  belongs_to :user
end
