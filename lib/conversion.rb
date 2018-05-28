require_relative  "./conversion/type"
require_relative  "./conversion/numbers"
require_relative  "./conversion/calculator"
require_relative  "./conversion/parse"
require_relative  "./conversion/converters/base"
require_relative  "./conversion/converters/roman"
require_relative  "./conversion/converters/alien"
require_relative  "./conversion/converters/woodchucker"

module Conversion
  extend self

  def add_conversion_type(symbol:, value:, name: , repeatable:, subtractable_by:)
    type = Conversion::Type.new(
      symbol: symbol, value: value, name: name,
      repeatable: repeatable, subtractable_by: subtractable_by
    )
    Conversion::Numbers.add type
  end

  def parse(string)
    Conversion::Parse.parse(string)
  end
end
