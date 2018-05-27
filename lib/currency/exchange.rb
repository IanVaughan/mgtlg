module Currency
  # A in-memory containers class for handling all known exchange rates.
  class Exchange
    # Adds an Exchange Rate to the system to allow converting from earth types
    # (gold/silver/iron) into galaxy credits

    # @param [Object] +exchange_rate+ of earth currency to exchange from
    # @example
    #   irb> exchange_rate = Currency::ExchangeRate.new(name: :silver, value: 2)
    #   irb> Currency::Exchange.new(exchange_rate)
    def initialize(exchange_rate)
      Exchange.exchange_rates ||= []
      Exchange.exchange_rates << exchange_rate
    end

    class << self
      def find_currency(name)
        Exchange.exchange_rates&.select { |rate| rate.name == name }&.first
      end

      # ExchangeRate::VALID_EARTH_CURRENCIES.each do |currency|
      #   define_method currency do
      #     find_currency(currency)
      #   end
      # end

      attr_accessor :exchange_rates
    end
  end
end
