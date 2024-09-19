# frozen_string_literal: true

module Operations
  module My
    module UserFollows
      class Follow < Operations::Base
        def call(followed_id:, follower:)
          followed = yield find_followed(followed_id)
          yield not_self?(followed, follower)
          yield commit(followed, follower)
          Success(followed)
        end

        private

        def find_followed(followed_id)
          followed = User.find(followed_id)
          Success(followed)
        rescue ActiveRecord::RecordNotFound
          Failure[:not_found, 'User not found']
        end

        def not_self?(followed, follower)
          return Success(true) if followed != follower

          Failure[:self_following, 'You cannot follow yourself']
        end

        def commit(followed, follower)
          followed.followers.create!(follower: follower)
          Success(true)
        rescue ActiveRecord::RecordNotUnique
          Failure[:already_following, 'You are already following this user']
        end
      end
    end
  end
end
