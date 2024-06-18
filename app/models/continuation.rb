class Continuation < ApplicationRecord
  belongs_to :user
  belongs_to :habit
  validates :now, inclusion: {in: [true, false], message: "選択してください"}
end
