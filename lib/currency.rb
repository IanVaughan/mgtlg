require_relative  "./currency/exchange_rate"
require_relative  "./currency/exchange"
require_relative  "./currency/money"

module Currency
  extend self

  # Save a new Exchange rate between some earth type and credits
  # Add some exchange rates (a default set is already created on startup)
  # > Currency.add_exchange_rate(name: :iron, value: 195.5)
  def add_exchange_rate(name:, value:)
    rate = Currency::ExchangeRate.new(name: name, value: value)
    Currency::Exchange.new(rate)
  end

  # Convert units of a known earth currency type into credits
  # Can now convert units of that earth type into credits
  # > Currency.money(2, :iron)
  # => iron - 2 - 391.0
  def money(amount, name)
    Currency::Money.new(amount, name)
  end

  # Get a list of all currently known exchange rates
  def exchange_rates
    Currency::Exchange.exchange_rates
  end
end
