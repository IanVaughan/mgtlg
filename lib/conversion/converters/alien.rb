module Conversion
  module Converters
    # Converts a string of Alien words into an array of number Types
    # @example
    # irb> types = [Conversion::Type.new(name: "foo)]
    # irb> Conversion::Alien::Converter.new("foo foo", types)

    class Alien < Base
      def can_convert?
        words = current_words

        string.split.all? { |w| words.include? w }
      end

      def convert
        string.split.map { |char| find(char) }
      end

      private

      def current_words
        number_types.collect { |n| n.name }.compact
      end

      def find(char)
        number_types.select { |number| number.name == char }.first
      end
    end

    Parse.register(Alien)
  end
end
