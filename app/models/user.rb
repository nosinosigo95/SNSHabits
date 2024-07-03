class User < ApplicationRecord
  # 関連付け
  has_many :comments, dependent: :destroy
  has_many :habits
  has_many :favorite_habits, dependent: :destroy
  has_many :favorites, through: :favorite_habits, source: :habit
  has_many :continuations, dependent: :destroy
  has_many :continuation_habits, through: :continuations, source: :habit
  has_many :diaries, dependent: :destroy
  has_many(
    :follower_relations,
    class_name: "Follow",
    foreign_key: "follower_id",
    dependent: :destroy,
  )
  has_many(
    :followed_relations,
    class_name: "Follow",
    foreign_key: "followed_id",
    dependent: :destroy,
  )
  # 簡潔に取得
  has_many :followers, through: :follower_relations, source: :followed
  has_many :followings, through: :followed_relations, source: :follower
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  INTRO_MAX = 400
  validates :name, presence: true, uniqueness: true
  validates :introduction, length: { maximum: INTRO_MAX }
  has_one_attached :icon

  def follow(followed_user)
    follower_relations.create(followed_id: followed_user.id)
  end

  def unfollow(unfollowed_user)
    follower_relations.find_by(followed_id: unfollowed_user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
end
