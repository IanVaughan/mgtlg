module Conversion
  module Converters
    # Abstract base class for the Converters interface
    class Base
      def initialize(string, number_types)
        @string = string
        @number_types = number_types
      end

      def can_convert?
        raise NotImplementedError
      end

      def convert
        raise NotImplementedError
      end

      protected

      attr_reader :string, :number_types
    end
  end
end
