# frozen_string_literal: true

module My
  class PostsController < My::BaseController
    def index
      @posts = current_my_user.posts.reorder(id: :desc)
    end

    def new
      @post = current_my_user.posts.new
    end

    def create
      operation = Operations::My::Posts::Create.run(post_params.to_h)

      case operation
      in Success[post]
        @post = post
        respond_to do |format|
          format.html { redirect_to my_post_path(post) }
          format.turbo_stream
        end
      in Failure[error_code, errors]
        @post = current_my_user.posts.new(post_params)
        render :new
      end
    end

    private

    def post_params
      params.require(:post).permit(:user_id, :title, :content)
    end
  end
end
