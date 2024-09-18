# frozen_string_literal: true

module Operations
  class Base
    include Dry::Monads[:result, :do]

    def self.run(*args)
      new.call(*args)
    end

    def call(*args)
      raise NotImplementedError
    end
  end
end
