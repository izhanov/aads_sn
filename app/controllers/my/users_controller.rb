# frozen_string_literal: true

module My
  class UsersController < My::BaseController
    def show
      @user = User.find(params[:id])
    end
  end
end
