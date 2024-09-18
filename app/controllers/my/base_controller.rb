# frozen_string_literal: true

module My
  class BaseController < ApplicationController
    layout "my"

    before_action :authenticate_my_user!
  end
end
