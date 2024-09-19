# frozen_string_literal: true

module My
  class UserFollowersController < My::BaseController
    def index
      @followers = current_my_user.followers
    end

    def create
      operation = Operations::My::UserFollows::Accept.run(follower_id: params[:follower_id], followed: current_my_user)

      case operation
      in Success[follower]
        redirect_to my_followers_path
      in Failure[error_code, errors]
        redirect_to my_followers_path
      end
    end

    def destroy
      operation = Operations::My::UserFollows::Reject.run(follower_id: params[:follower_id], followed: current_my_user)

      case operation
      in Success[follower]
        redirect_to my_followers_path
      in Failure[error_code, errors]
        redirect_to my_followers_path
      end
    end
  end
end
