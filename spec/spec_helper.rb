require "pry"
require "./load_app"
require 'currency'
require 'conversion'
require 'text_input'

RSpec.configure do |config|
  config.before(:each) do
    # reset in-memory story for other tests
    # TODO: move to where needed or add tag
    Currency::Exchange.exchange_rates = nil
  end
end
