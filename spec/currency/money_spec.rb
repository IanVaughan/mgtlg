RSpec.describe Currency::Money do
  describe "#initialize" do
    let(:input) { described_class.new(amount, name) }
    let(:amount) { 2 }
    let(:name) { :gold }

    it "creates a valid Exchange instance" do
      expect(input).to be_an_instance_of(described_class)
    end

    it "allows access to the name, value and credits" do
      expect(input.amount).to eq amount
      expect(input.name).to eq name
      expect(input.credits).to eq described_class::UNKNOWN
    end

    it "represents itself as a formatted string" do
      expect(input.to_s).to eq "#{name} - #{amount} - #{described_class::UNKNOWN}"
    end

    context "with exchange rates present" do
      let(:rate) { Currency::ExchangeRate.new(name: name, value: 100) }
      before { Currency::Exchange.new(rate) }

      it "calculates the credits from the exchange rate" do
        expect(input.credits).to eq rate.value * amount
      end
    end
  end
end
