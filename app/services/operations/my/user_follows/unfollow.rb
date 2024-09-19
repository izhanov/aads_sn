# frozen_string_literal: true

module Operations
  module My
    module UserFollows
      class Unfollow < Operations::Base
        def call(followed:, follower:)
          yield not_self?(followed, follower)
          yield followed?(followed, follower)
          yield commit(followed, follower)
          Success(followed)
        end

        private

        def not_self?(followed, follower)
          return Success(true) if followed != follower

          Failure[:self_following, 'You cannot unfollow yourself']
        end

        def followed?(followed, follower)
          return Success(true) if follower.followed.approved.find_by(followed: followed)

          Failure[:not_following, 'You are not following this user']
        end

        def commit(followed, follower)
          follower.followed.find_by(followed: followed).delete
          Success(true)
        end
      end
    end
  end
end
