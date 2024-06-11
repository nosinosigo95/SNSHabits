class Source < ApplicationRecord
  validates :url, presence: true
  belongs_to :habit
end
