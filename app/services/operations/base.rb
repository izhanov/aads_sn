# frozen_string_literal: true

module Operations
  class Base
    include Dry::Monads[:result, :do]

    def self.run(*args, **kwargs)
      new.call(*args, **kwargs)
    end

    def call(*args, **kwargs)
      raise NotImplementedError
    end
  end
end
