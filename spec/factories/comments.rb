# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { "This is a comment." }

    transient do
      author_type { 'User' }
    end

    association :author, factory: :user

    trait :with_author do
      association :author, factory: :user
    end

    association :commentable, factory: :post
    parent { nil }

    after(:build) do |comment, evaluator|
      comment.author = build(:user) if evaluator.author_type == 'User'
      comment.author = build(:system) if evaluator.author_type == 'System'
    end
  end
end
