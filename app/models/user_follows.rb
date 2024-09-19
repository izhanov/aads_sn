# frozen_string_literal: true

class UserFollows < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  has_many :follower_posts, through: :follower, source: :posts
  has_many :followed_posts, through: :followed, source: :posts

  STATUSES = %w[PENDING APPROVED REJECTED].freeze

  scope :pending, -> { where(status: "PENDING") }
  scope :approved, -> { where(status: "APPROVED") }
  scope :rejected, -> { where(status: "REJECTED") }
end
