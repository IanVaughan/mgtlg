module Conversion
  module Converters
    # Converts a string of Roman numerals into an array of number Types
    # @example
    # irb> types = [Conversion::Type.new(symbol: "M")]
    # irb> Conversion::Roman::Converter.new("MM", types)

    class Roman < Base
      def can_convert?
        return if string.nil?
        symbols = current_symbols
        string.chars.all? { |w| symbols.include? w }
      end

      def convert
        string.chars.map { |char| find(char) }
      end

      private

      def current_symbols
        number_types.collect { |n| n.symbol }.compact
      end

      def find(char)
        number_types.select { |number| number.symbol == char }.first
      end
    end

    Parse.register(Roman)
  end
end
