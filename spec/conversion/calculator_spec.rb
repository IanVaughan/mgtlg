RSpec.describe Conversion::Calculator do
  describe "#convert" do
    let(:i) { double("I", symbol: "I", value: 1, repeatable?: true, subtractable_by: ["V", "X"]) }
    let(:v) { double("V", symbol: "V", value: 5, repeatable?: false, subtractable_by: nil) }
    let(:x) { double("X", symbol: "X", value: 10, repeatable?: true, subtractable_by: ["L", "C"]) }
    let(:l) { double("L", symbol: "L", value: 50, repeatable?: false, subtractable_by: nil) }
    let(:c) { double("C", symbol: "C", value: 100, repeatable?: true, subtractable_by: ["D","M"]) }
    let(:d) { double("D", symbol: "D", value: 500, repeatable?: false, subtractable_by: nil) }
    let(:m) { double("M", symbol: "M", value: 1_000, repeatable?: true, subtractable_by: nil) }

    let(:instance) { described_class.new(number_set) }
    subject { instance.result }

    context "example MMVI" do
      let(:number_set) { [m,m,v,i] }
      it { is_expected.to eq 2006 }
    end

    context "example MCMXLIV" do
      let(:number_set) { [m,c,m,x,l,i,v] }
      it { is_expected.to eq 1944 }
    end

    context "example CM that subtracts" do
      let(:number_set) { [c, m] }
      it { is_expected.to eq 900 }
    end

    describe "D, L, and V can never be repeated" do
      context "example DD that cannot repeat" do
        let(:number_set) { [d, d] }

        it "raises an error" do
          expect { subject }.to raise_error(described_class::UnrepeatableTypeError)
        end
      end

      context "example LL that cannot repeat" do
        let(:number_set) { [l, l] }

        it "raises an error" do
          expect { subject }.to raise_error(described_class::UnrepeatableTypeError)
        end
      end

      context "example V that cannot repeat" do
        let(:number_set) { [v, v] }

        it "raises an error" do
          expect { subject }.to raise_error(described_class::UnrepeatableTypeError)
        end
      end
    end

    describe "symbols I, X, C and M can be repeated three times in succession" do
      context "example I that can repeat 3 times" do
        let(:number_set) { [i, i, i, i] }

        it "raises an error" do
          expect { subject }.to raise_error(described_class::RepeatedTooManyTimesError)
        end
      end
    end

    describe "I can be subtracted from V and X only." do
      context "allows IV" do
        let(:number_set) { [i, v] }
        it { is_expected.to eq 4 }
      end

      context "does not allow IM" do
        let(:number_set) { [i, m] }

        it "raises an error" do
          expect { subject }.to raise_error(described_class::UnsubtractableError)
        end
      end
    end

    describe "V, L, and D can never be subtracted" do
      context "does not allow DM" do
        let(:number_set) { [d, m] }

        it "raises an error" do
          expect { subject }.to raise_error(described_class::UnsubtractableError)
        end
      end
    end
  end
end
