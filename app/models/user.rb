class User < ApplicationRecord
  # 関連付け
  has_many :habits
  has_many :follower_relations, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :followed_relations, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy

  # 簡潔に取得
  has_many :followers, through: :follower_relations, source: :follower
  has_many :followings, through: :followed_relations, source: :followed

  INTRO_MAX = 400
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable # , :confirmable
  validates :name, presence: true, uniqueness: true
  validates :introduction, length: { maximum: INTRO_MAX }
  has_one_attached :icon

  def follow(followed_user)
    follower_relations.create(followed: followed_user.id)
  end

  def unfollow(unfollowed_user)
    follower_relations.find_by(followed: followed_user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
end
