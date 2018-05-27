module Conversion
  # These are the known currency values at present
  # They could be loaded from a database, or some external source/API, but for now they are listed below
  class Type
    # Describes the properties of a currency
    # Converter::Type.new(symbol: "I", value: 1, name: "glob", repeatable: true, subtractable_by: ["V", "X"])

    attr_reader :symbol, :value, :name, :repeatable, :subtractable_by

    def initialize(symbol:, value:, name: nil, repeatable:, subtractable_by: nil)
      @symbol = symbol
      @value = value
      @name = name
      @repeatable = repeatable
      @subtractable_by = subtractable_by || []
    end

    alias_method :repeatable?, :repeatable

    def subtractable?
      subtractable_by.any?
    end

    def to_s
      [symbol, value].join(" - ")
    end

    def inspect
      "#{self}"
    end
  end
end
