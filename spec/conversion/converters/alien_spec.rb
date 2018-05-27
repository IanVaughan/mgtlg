RSpec.describe Conversion::Converters::Alien do
  describe "#can_convert?" do
    let(:x) { double("X", name: "pish") }
    let(:number_types) { [x] }
    let(:instance) { described_class.new(input, number_types) }
    subject { instance.can_convert? }

    context "with alien words" do
      let(:input) { "pish pish pish" }
      it { is_expected.to eq true }
    end

    context "with non-roman numerals" do
      let(:input) { "moo" }
      it { is_expected.to eq false }
    end
  end

  describe "#convert" do
    let(:i) { double("I", name: "glob") }
    let(:v) { double("V", name: "prok") }
    let(:x) { double("X", name: "pish") }
    let(:l) { double("L", name: "tegj") }

    let(:number_types) { [i, v, x, l] }

    let(:instance) { described_class.new(input, number_types) }
    subject { instance.convert }

    context "example MMVI" do
      let(:input) { "MMVI" }
      it { is_expected.to eq [nil] }
    end

    context "example pish tegj glob glob" do
      let(:input) { "pish tegj glob glob" }
      it { is_expected.to eq [x,l,i,i] }
    end
  end
end
