class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :posts, dependent: :destroy
  has_many :comments, as: :author, dependent: :destroy

  has_many :user_followers, class_name: "UserFollows", foreign_key: "followed_id", dependent: :destroy
  has_many :user_followed, class_name: "UserFollows", foreign_key: "follower_id", dependent: :destroy

  has_many :followers, through: :user_followers, source: :follower
  has_many :followed, through: :user_followed, source: :followed
end
