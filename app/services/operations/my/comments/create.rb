# frozen_string_literal: true

module Operations
  module My
    module Comments
      class Create < Operations::Base
        def call(author:, commentable:, content:)
          yield can_comment?(author, commentable)
          yield validate(content)
          comment = yield commit(author, commentable, content)
          Success(comment)
        end

        private

        def can_comment?(author, commentable)
          Success(true)
        end

        def validate(content)
          if content.blank?
            Failure[:validation_error, { content: ["can't be blank"] }]
          else
            Success(content)
          end
        end

        def commit(author, commentable, content)
          comment = commentable.comments.create!(author: author, content: content)
          Success(comment)
        end
      end
    end
  end
end
