require_relative 'monad'
module NilBeGone

  class Optional < Monad

    attr_reader :value
    def initialize(value)
      @value = value
    end

    def and_then(&block)
      if value.nil?
        from_value(nil)
      else
        from_value(block.call(value))
      end
    end

    def from_value(value)
      Optional.new(value)
    end

    # to enable method chaining
    def method_missing(*args, &block)
      and_then do |value|
        value.public_send(*args, &block)
      end
    end
  end
end