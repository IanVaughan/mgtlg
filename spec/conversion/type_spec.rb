RSpec.describe Conversion::Type do
  let(:symbol) { "I" }
  let(:value) { 1 }
  let(:name) { "glob" }
  let(:repeatable) { true }
  let(:subtractable_by) { ['V'] }

  let(:input) do
    described_class.new(symbol: symbol, value: value, name: name, repeatable: repeatable, subtractable_by: subtractable_by)
  end

  it "creates a valid instance" do
    expect(input).to be_an_instance_of(described_class)
  end

  it "allows access to the attributes" do
    expect(input.symbol).to eq symbol
    expect(input.value).to eq value
    expect(input.name).to eq name
    expect(input.repeatable).to eq repeatable
    expect(input.subtractable_by).to eq subtractable_by
  end

  it "represents itself as a formatted string" do
    expect(input.to_s).to eq "#{symbol} - #{value}"
  end

  describe "#repeatable?" do
    subject { input.repeatable? }

    context "when repeatable false" do
      let(:repeatable) { false }
      it { is_expected.to eq false }
    end

    context "when repeatable true" do
      let(:repeatable) { true }
      it { is_expected.to eq true }
    end
  end

  describe "#subtractable?" do
    subject { input.subtractable? }

    context "when subtractable_by is given an array of letters" do
      let(:subtractable_by) { ['V'] }
      it { is_expected.to eq true }
    end

    context "when subtractable_by is given nil" do
      let(:subtractable_by) { nil }
      it { is_expected.to eq false }
    end
  end
end
