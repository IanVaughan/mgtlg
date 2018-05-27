RSpec.describe Conversion::Calculator do
  describe "#convert" do
    let(:i) { double("I", value: 1, repeatable?: true) }
    let(:v) { double("V", value: 5, repeatable?: false) }
    let(:x) { double("X", value: 10, repeatable?: true) }
    let(:l) { double("L", value: 50, repeatable?: false) }
    let(:c) { double("C", value: 100, repeatable?: true) }
    let(:d) { double("D", value: 500, repeatable?: false) }
    let(:m) { double("M", value: 1_000, repeatable?: true) }

    let(:instance) { described_class.new(number_set) }
    subject { instance.result }

    # before do
    #   allow(v).to receive(:used)
    #   allow(i).to receive(:used)
    #   allow(m).to receive(:used=)
    # end
    #
    context "example MMVI" do
      let(:number_set) { [m,m,v,i] }
      it { is_expected.to eq 2006 }
    end

    context "example CM that subtracts" do
      let(:number_set) { [c,m] }
      it { is_expected.to eq 900 }
    end

    context "example DD that cannot repeat" do
      let(:number_set) { [d,d] }

      it "raises an error" do
        expect { subject }.to raise_error(described_class::UnrepeatableTypeError)
      end
    end

    context "example MCMXLIV" do
      let(:number_set) { [m,c,m,x,l,i,v] }
      it { is_expected.to eq 1944 }
    end
  end
end
