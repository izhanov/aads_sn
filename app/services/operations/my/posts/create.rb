# frozen_string_literal: true

module Operations
  module My
    module Posts
      class Create < Operations::Base
        def call(params)
          validated_params = yield validate(params)
          post = yield commit(validated_params.to_h)
          Success(post)
        end

        private

        def validate(params)
          validation = Validations::My::Posts::Create.new.call(params)
          validation
            .to_monad
            .or { |failure| Failure[:validation_error, failure.errors.to_h] }
        end

        def commit(params)
          post = Post.create!(params)
          Success(post)
        end
      end
    end
  end
end
