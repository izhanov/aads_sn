# frozen_string_literal: true

module Operations
  module My
    module UserFollows
      class Accept < Operations::Base
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
          Failure[:follower_not_found, 'Follower not found']
        end

        def commit(follower, followed)
          followed.transaction do
            follows = followed.user_followers.find_by!(follower: follower, status: "PENDING")
            follows.update!(status: "APPROVED")
          end
          Success(true)
        end
      end
    end
  end
end
