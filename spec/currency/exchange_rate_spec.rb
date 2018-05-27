RSpec.describe Currency::ExchangeRate do
  let(:value) { 1 }
  let(:input) { described_class.new(name: name, value: value) }

  context "with a valid currency name" do
    let(:name) { :silver }

    it "creates a valid instance" do
      expect(input).to be_an_instance_of(described_class)
    end

    it "allows access to the name and value" do
      expect(input.name).to eq name
      expect(input.value).to eq value
    end

    it "represents itself as a formatted string" do
      expect(input.to_s).to eq "#{name} - #{value}"
    end
  end

  context "with an invalid currency name" do
    let(:name) { :foobar }

    let(:error_text) do
      "invalid earth currency name:#{name}, must be one of #{described_class::VALID_EARTH_CURRENCIES}"
    end

    it "raises an error" do
      expect { input }.to raise_error(RuntimeError, error_text)
    end
  end
end
