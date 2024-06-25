class Source < ApplicationRecord
  belongs_to :habit

  validates :url, presence: true
end
