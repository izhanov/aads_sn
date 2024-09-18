class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :posts, dependent: :destroy

  has_many :followers, class_name: "UserFollows", foreign_key: "followed_id", dependent: :destroy
  has_many :followed, class_name: "UserFollows", foreign_key: "follower_id", dependent: :destroy
end
