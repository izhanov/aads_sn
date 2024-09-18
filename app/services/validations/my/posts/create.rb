# frozen_string_literal: true

module Validations
  module My
    module Posts
      class Create < Dry::Validation::Contract
        params do
          required(:user_id).filled(:integer)
          required(:title).filled(:string)
          required(:content).filled(:string)
        end
      end
    end
  end
end
