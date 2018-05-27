RSpec.describe Currency::Exchange do
  let(:exchange_rate) { double "exchange rate", name: name }

  describe "#initialize" do
    let!(:input) { described_class.new(exchange_rate) }
    let(:name) { :doesnt_matter }

    it "creates a valid Exchange instance" do
      expect(input).to be_an_instance_of(described_class)
    end

    it "persists known rates to an in-memory array" do
      expect(described_class.exchange_rates.count).to eq 1
      expect(described_class.exchange_rates.last).to eq exchange_rate
    end
  end

  describe ".find_currency" do
    subject { described_class.find_currency(search_name) }

    context "when no exchange rates have been added" do
      let(:search_name) { :doesnt_exist }

      it { is_expected.to eq nil }
    end

    context "when exchange rates have been added" do
      let(:name) { :find_me }
      let!(:add_rate) { described_class.new(exchange_rate) }

      context "when searching something that exists" do
        let(:search_name) { name }

        it { is_expected.to eq exchange_rate }
      end

      context "when searching something that doesnt exists" do
        let(:search_name) { :doesnt_exist }

        it { is_expected.to eq nil }
      end
    end
  end
end
