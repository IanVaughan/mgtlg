module Conversion
  class RomanConverter
    def initialize(string, number_types)
      @string = string
      @number_types = number_types
    end

    def convert
      string.split("").map { |char| find(char) }
    end

    private

    attr_reader :string, :number_types

    def find(char)
      number_types.select { |number| number.symbol == char }.first
    end
  end
end
