module Currency
  # Describes an exchange rate from an earth value into galaxy credits
  class ExchangeRate
    VALID_EARTH_CURRENCIES = %i(silver gold iron).freeze
    # TODO: Allow :credits to convert backwards

    attr_reader :name, :value

    # Create a Exchange rate
    # @example
    #   irb> silver = Currency::ExchangeRate.new(name: :silver, value: 17)
    #   irb> silver.value #=> 17
    #
    def initialize(name:, value:)
      # TODO: extra validation, eg nil, number, etc
      # TODO: replace if same type used
      ensure_valid_currency(name)

      @name = name
      @value = value
    end

    def to_s
      [name, value].join(" - ")
    end

    def inspect
      "#{self}"
    end

    private

    def ensure_valid_currency(currency)
      return if VALID_EARTH_CURRENCIES.include? currency

      raise "invalid earth currency name:#{currency}, must be one of #{VALID_EARTH_CURRENCIES}"
    end
  end
end
