RSpec.describe Conversion::RomanConverter do
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
