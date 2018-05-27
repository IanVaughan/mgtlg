RSpec.describe Conversion::Converters::Roman do
  describe "#can_convert?" do
    let(:m) { double("M", symbol: "M") }
    let(:v) { double("V", symbol: "V") }
    let(:number_types) { [m, v] }

    let(:instance) { described_class.new(input, number_types) }
    subject { instance.can_convert? }

    context "with roman numerals" do
      let(:input) { "MMV" }
      it { is_expected.to eq true }
    end

    context "with non-roman numerals" do
      let(:input) { "moo" }
      it { is_expected.to eq false }
    end
  end

  describe "#convert" do
    let(:m) { double("M", symbol: "M") }
    let(:v) { double("V", symbol: "V") }
    let(:i) { double("I", symbol: "I") }
    let(:c) { double("C", symbol: "C") }
    let(:x) { double("X", symbol: "X") }
    let(:l) { double("L", symbol: "L") }
    let(:number_types) { [m, v, i, c, x, l] }

    let(:instance) { described_class.new(input, number_types) }
    subject { instance.convert }

    context "example MMVI" do
      let(:input) { "MMVI" }
      it { is_expected.to eq [m,m,v,i] }
    end

    context "example MCMXLIV" do
      let(:input) { "MCMXLIV" }
      it { is_expected.to eq [m,c,m,x,l,i,v] }
    end
  end
end
