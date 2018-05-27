module Conversion
  module Roman
    # Converts a string of Roman numerals into an array of number Types
    class Converter
      # @example
      # irb> types = [Conversion::Type.new(symbol: "M")]
      # irb> Conversion::Roman::Converter.new("MM", types)
      def initialize(string, number_types)
        @string = string
        @number_types = number_types
      end

      def convert
        string.chars.map { |char| find(char) }
      end

      private

      attr_reader :string, :number_types

      def find(char)
        number_types.select { |number| number.symbol == char }.first
      end
    end
  end
end
