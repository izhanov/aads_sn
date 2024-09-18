# frozen_string_literal: true

module My
  class WelcomeController < My::BaseController
    def index
      @posts = current_my_user.posts.reorder(id: :desc)
    end
  end
end
