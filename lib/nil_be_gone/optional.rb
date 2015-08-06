require_relative 'monad'
module NilBeGone

  class Optional < Monad

    attr_reader :value
    def initialize(value)
      @value = value
    end

    def and_then(&block)
      if value.nil?
        Optional.from_value(nil)
      else
        Optional.from_value(block.call(value))
      end
    end

    def self.from_value(value)
      Optional.new(value)
    end

    # to enable method chaining
    def method_missing(*args, &block)
      and_then do |value|
        value.public_send(*args, &block)
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      super || and_then do |value|
        value.respond_to?(method_name)
      end
    end
  end
end
