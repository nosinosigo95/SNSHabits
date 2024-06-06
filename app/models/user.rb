class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  INTRO_MAX = 400
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable#, :confirmable
  validates :name, presence: true, uniqueness: true
  validates :introduction, length: {maximum: INTRO_MAX}
  has_one_attached :icon
end
