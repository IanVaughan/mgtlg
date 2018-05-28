module TextInput
  class Answer
    HOW_MUCH = /how much is /
    HOW_MANY = /how many Credits is /

    def self.parse(text)
      case text
      when HOW_MUCH then process_how_much(text)
      when HOW_MANY then process_how_many(text)
      else process_other(text)
      end
    end

    def self.process_how_much(text)
      parsed_text = extract_keywords(HOW_MUCH, text)
      amount = Conversion.parse(parsed_text)
      "#{parsed_text} is #{amount}"
    end

    def self.process_how_many(text)
      parsed_text = extract_keywords(HOW_MANY, text)

      (currency, parsed_text) = extract_currency(parsed_text)

      amount = Conversion.parse(parsed_text)
      credits = Currency.money(amount, currency).credits

      "#{parsed_text} #{currency} is #{credits} Credits"
    end

    def self.process_other(text)
      return if text.nil?
      Conversion.parse(text.gsub!("?", "")&.strip&.downcase)
    end

    def self.extract_keywords(regexp, text)
      text.gsub!(regexp, "").gsub!("?", "").strip.downcase
    end

    def self.extract_currency(parsed_text)
      rate_names = Currency.exchange_rates.map { |rate| rate.name }
      currency = rate_names.find { |name| parsed_text.include? name.to_s }
      new_text = parsed_text.gsub!(currency.to_s, "").strip
      [currency, new_text]
    end
  end
end
