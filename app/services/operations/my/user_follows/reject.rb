# frozen_string_literal: true

module Operations
  module My
    module UserFollows
      class Reject < Operations::Base
        def call(follower_id:, followed:)
          follower = yield find_follower(follower_id, followed)
          yield commit(follower, followed)
          Success(follower)
        end

        private

        def find_follower(follower_id, followed)
          follower = followed.followers.where(user_follows: {status: "PENDING"}).find(follower_id)
          Success(follower)
        rescue ActiveRecord::RecordNotFound
          Failure[:follower_not_found, "Follower not found"]
        end

        def not_self?(followed, follower)
          return Success(true) if followed != follower

          Failure[:self_following, "You cannot reject yourself"]
        end

        def find_follows(follower, followed)
          follows = follower.followed.where(user_follows: {status: "PENDING"}).find(followed.id)
          Success(follows)
        rescue ActiveRecord::RecordNotFound
          Failure[:not_following, "Follower not follow this user"]
        end

        def commit(follower, followed)
          follows = followed.user_followers.find_by!(follower: follower, status: "PENDING")
          follows.update!(status: "REJECTED")
          Success(true)
        end
      end
    end
  end
end
