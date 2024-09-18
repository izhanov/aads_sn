# frozen_string_literal: true

module Validations
  module My
    module Users
      class Signup < Dry::Validation::Contract
        params do
          required(:name).filled(:string)
          required(:surname).filled(:string)
          required(:email).filled(:string)
          required(:phone).filled(:string)
          required(:password).filled(:string)
          required(:password_confirmation).filled(:string)
        end

        rule(:password, :password_confirmation) do
          key.failure("passwords must match") if values[:password] != values[:password_confirmation]
        end
      end
    end
  end
end
