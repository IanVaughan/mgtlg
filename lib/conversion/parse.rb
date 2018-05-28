module Conversion
  # Main class responsible for converting an input into a value of credits
  class Parse
    class << self
      class NoMatchingConverterError < RuntimeError; end

      attr_accessor :converters

      # Adds a new Converter to the candidates to be used to parse inputs
      def register(converter)
        self.converters ||= []
        self.converters << converter
      end

      # Parses a string input against all known converters
      # and then calculates the resulting number of credits
      def parse(input, calculator = Calculator)
        converter = match(input)
        raise NoMatchingConverterError if converter.nil?

        number_set = converter.convert
        return number_set if number_set.class == String

        calculator.new(number_set).result
      end

      private

      def init_all_converters(input)
        self.converters.map { |converter| converter.new(input, numbers) }
      end

      def match(input)
        converters = init_all_converters(input)
        converters.find { |converter| converter.can_convert? }
      end

      def numbers
        Numbers.numbers
      end
    end
  end
end
