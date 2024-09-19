# frozen_string_literal: true

module Operations
  module My
    module UserFollows
      class Reject < Operations::Base
        def call(follower_id:, followed:)
          follower = yield find_follower(follower_id)
          yield not_self?(followed, follower)
          follows = yield find_follows(follower, followed)
          yield commit(follows)
          Success(follower)
        end

        private

        def find_follower(follower_id)
          follower = User.find(follower_id)
          Success(follower)
        rescue ActiveRecord::RecordNotFound
          Failure[:follower_not_found, "Follower not found"]
        end

        def not_self?(followed, follower)
          return Success(true) if followed != follower

          Failure[:self_following, "You cannot reject yourself"]
        end

        def find_follows(follower, followed)
          follows = follower.followed.pending.find_by!(followed: followed)
          Success(follows)
        rescue ActiveRecord::RecordNotFound
          Failure[:not_following, "Follower not follow this user"]
        end

        def commit(follows)
          follows.update!(status: "REJECTED")
          Success(true)
        end
      end
    end
  end
end
