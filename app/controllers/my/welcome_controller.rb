# frozen_string_literal: true

module My
  class WelcomeController < My::BaseController
    def index
      @followed = current_my_user.
        followed.includes(:posts).
        where(user_follows: {status: "APPROVED"}).order("posts.created_at DESC")
      @followed_posts = @followed.map(&:posts).flatten
    end
  end
end
