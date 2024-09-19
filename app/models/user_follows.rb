# frozen_string_literal: true

class UserFollows < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  STATUSES = %w[PENDING APPROVED REJECTED].freeze

  scope :pending, -> { where(status: "PENDING") }
  scope :approved, -> { where(status: "APPROVED") }
  scope :rejected, -> { where(status: "REJECTED") }
end
