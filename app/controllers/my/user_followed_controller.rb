# frozen_string_literal: true

module My
  class UserFollowedController < My::BaseController
    def index
      @followed = current_my_user.followed
    end

    def create
      operation = Operations::My::UserFollows::Follow.run(followed_id: params[:followed_id], follower: current_my_user)

      case operation
      in Success[followed]
        redirect_to my_followed_index_path
      in Failure[error_code, errors]
        redirect_to my_followed_index_path
      end
    end

    def destroy
      operation = Operations::My::UserFollows::Unfollow.run(followed: followed, follower: current_my_user)

      case operation
      in Success[followed]
        redirect_to my_followed_index_path
      in Failure[error_code, errors]
        redirect_to my_followed_index_path
      end
    end

    private

    def followed
      @followed ||= User.find(params[:followed_id])
    end
  end
end
