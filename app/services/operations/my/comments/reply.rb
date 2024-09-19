# frozen_string_literal: true

module Operations
  module My
    module Comments
      class Reply < Operations::Base
        def call(author:, commentable:, content:, parent_comment:)
          yield can_reply?(author, commentable)
          yield validate(content)
          comment = yield commit(author, commentable, content, parent_comment)
          Success(comment)
        end

        private

        def can_reply?(author, commentable)
          Success(true)
        end

        def validate(content)
          if content.blank?
            Failure[:validation_error, { content: ["can't be blank"] }]
          else
            Success(content)
          end
        end

        def commit(author, commentable, content, parent_comment)
          comment = commentable.comments.create!(author: author, content: content, parent: parent_comment)
          Success(comment)
        end
      end
    end
  end
end
