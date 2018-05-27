module Conversion
  # Calculates the value of an ordered set of number Types
  class Calculator
    class UnrepeatableTypeError < RuntimeError; end

    # @example
    # irb> numbers = [Conversion::Type.new(symbol: "M"), Conversion::Type.new(symbol: "M")]
    # irb> Conversion::Calculator.new(numbers)
    # => 2000
    def initialize(number_set)
      @number_set = number_set
    end

    def result
      recurse(number_set)
    end

    private

    attr_reader :number_set

    def recurse(set, sum = 0)
      first, second = set[0..1]

      # end of list handling
      return final_value(set, sum, first) if second.nil?

      # validation rules
      validate_repeatable(first, second)

      # extracting pair or not then recurse the rest
      extract_value(first, second, set, sum)
    end

    def extract_value(first, second, set, sum)
      if first.value < second.value
        set.shift(2)
        recurse(set, sum + (second.value - first.value))
      else
        set.shift(1)
        recurse(set, sum + first.value)
      end
    end

    def final_value(set, sum, first)
      set.empty? ? sum : sum + first.value
    end

    def validate_repeatable(first, second)
      return unless !first.repeatable? && first == second

      raise UnrepeatableTypeError, "cannot repeat #{first}"
    end
  end
end
