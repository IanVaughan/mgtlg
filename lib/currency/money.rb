module Currency
  class Money
    UNKNOWN = "unknown".freeze

    attr_reader :name, :amount

    # Create money objects that allow conversion into credits
    # If the currency type exists then the number of credit
    # will be calculated, otherwise the value of this money
    # transaction is unknown
    # TODO: push unknowns into a pool to recheck
    # TODO: push all into a pool to update value depending on exchange rate changes, or add #refresh
    #
    # @param [Integer] +amount+ of earth currency to exchange from
    # @param [Symbol] +name+ of currency in credits
    # @example
    # irb> silver = Money.new(2, :silver)
    # irb> money.name     #=> :silver
    # irb> money.amount   #=> 2
    # irb> money.credits  #=> 34
    def initialize(amount, name)
      @amount = amount
      @name = name
      @credits = credits
    end

    def to_s
      [name, amount, credits].join(" - ")
    end

    def inspect
      "#{self}"
    end

    def credits
      return UNKNOWN if exchange_rate.nil?
      amount * exchange_rate
    end

    private

    def exchange_rate
      Exchange.find_currency(name)&.value
    end
  end
end
