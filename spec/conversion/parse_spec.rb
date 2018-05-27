RSpec.describe Conversion::Parse do
  before { described_class.converters.clear }

  describe "#register" do
    subject { described_class.register(converter) }
    let!(:converter) { double "converter" }
    it { is_expected.to eq [converter] }
  end

  describe "#parse" do
    let(:mock_converter) do
      Class.new do
        def can_convert?
          true
        end

        def initialize(_string, _number_types)
        end

        def convert
        end
      end
    end

    let(:mock_calculator) do
      Class.new do
        def initialize(_number_set)
        end

        def result
          456
        end
      end
    end

    before { described_class.register(mock_converter) }
    let(:input) { double "123" }
    subject { described_class.parse(input, mock_calculator) }
    it { is_expected.to eq 456 }
  end
end
