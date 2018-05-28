module Conversion
  # Calculates the value of an ordered set of number Types
  # This implementation recourses through the array of number types passed in
  # looking forward either one or two entries depending on what action is required.
  # eg with "MM" as the second M is just a normal sum so it can be ignored.
  # eg for "CM" the "C" has to be subtracted from the M, and the M must be removed
  # so not considered for a sum on the next loop.
  class Calculator
    class UnrepeatableTypeError < RuntimeError; end
    class RepeatedTooManyTimesError < RuntimeError; end
    class UnsubtractableError < RuntimeError; end

    MAX_REPEAT_COUNT = 3

    # @param [Array<Type>] +number_set+ array of Types that should be used to calculate the result from
    # @example
    # irb> numbers = [Conversion::Type.new(symbol: "M"), Conversion::Type.new(symbol: "M")]
    # irb> Conversion::Calculator.new(numbers)
    # => 2000
    def initialize(number_set)
      @number_set = number_set
    end

    def result
      recurse(@number_set)
    end

    private

    def recurse(set, sum = 0, repeated_count = 0)
      first, second = set[0..1]

      # end of list handling
      return final_value(set, sum, first) if second.nil?

      # validation rules
      validate_repeatable(first, second, repeated_count)

      # extracting pair or not then recurse the rest
      extract_value(first, second, set, sum, repeated_count)
    end

    def extract_value(first, second, set, sum, repeated_count)
      (first == second) ? repeated_count += 1 : repeated_count = 0

      if first.value < second.value
        set.shift(2)
        validate_subtractable(first, second)
        recurse(set, sum + (second.value - first.value), repeated_count)
      else
        set.shift(1)
        recurse(set, sum + first.value, repeated_count)
      end
    end

    def final_value(set, sum, first)
      set.empty? ? sum : sum + first.value
    end

    def validate_repeatable(first, second, repeated_count)
      raise RepeatedTooManyTimesError if repeated_count >= MAX_REPEAT_COUNT - 1
      return unless !first.repeatable? && first == second

      raise UnrepeatableTypeError, "cannot repeat #{first}"
    end

    def validate_subtractable(first, second)
      raise UnsubtractableError, "cannot subtract #{first} from anything" if first.subtractable_by.nil?

      return if first.subtractable_by.any? { |symbol| symbol == second.symbol }

      raise UnsubtractableError, "cannot subtract #{first} from #{second}"
    end
  end
end
