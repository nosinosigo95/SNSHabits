class Diary < ApplicationRecord
  has_one :habit
  belongs :user
end
