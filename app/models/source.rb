class Source < ApplicationRecord
  validates :url, precense: true
  belongs_to: habit
end
