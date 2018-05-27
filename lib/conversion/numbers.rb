module Conversion
  # Container for in-memory store of all known numbers
  class Numbers
    class << self
      attr_accessor :numbers

      def add(type)
        # TODO: check type is valid

        self.numbers ||= []
        self.numbers << type
      end
    end
  end
end
