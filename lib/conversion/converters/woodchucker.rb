module Conversion
  module Converters
    # Converts a string of Roman numerals into an array of number Types
    # @example
    # irb> types = [Conversion::Type.new(symbol: "M")]
    # irb> Conversion::Roman::Converter.new("MM", types)

    class Woodchucker < Base
      MATCH = "how much wood could a woodchuck chuck if a woodchuck could chuck wood".freeze

      def can_convert?
        string == MATCH
      end

      def convert
        "I have no idea what you are talking about"
      end
    end

    Parse.register(Woodchucker)
  end
end
