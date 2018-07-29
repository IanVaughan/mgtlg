RSpec.describe TextInput::Answer do
  let(:text) { "how much is pish tegj glob glob ?" }
  let(:extracted_text) { "pish tegj glob glob is 42" }

  subject { TextInput.answer(text) }

  before do
    Currency.add_exchange_rate(name: :silver, value: 17)
    Currency.add_exchange_rate(name: :gold, value: 14_450)
    Currency.add_exchange_rate(name: :iron, value: 195.5)

    Conversion.add_conversion_type(symbol: "I", value: 1, name: "glob", repeatable: true, subtractable_by: ["V", "X"])
    Conversion.add_conversion_type(symbol: "V", value: 5, name: "prok", repeatable: false, subtractable_by: nil)
    Conversion.add_conversion_type(symbol: "X", value: 10, name: "pish", repeatable: true, subtractable_by: ["L", "C"])
    Conversion.add_conversion_type(symbol: "L", value: 50, name: "tegj", repeatable: false, subtractable_by: nil)
    Conversion.add_conversion_type(symbol: "C", value: 100, name: nil, repeatable: true, subtractable_by: ["D","M"])
    Conversion.add_conversion_type(symbol: "D", value: 500, name: nil, repeatable: false, subtractable_by: nil)
    Conversion.add_conversion_type(symbol: "M", value: 1_000, name: nil, repeatable: true, subtractable_by: nil)
  end

  describe "Input produces correct output" do
    it "produces correct result" do
      is_expected.to eq extracted_text
    end

    context "ensures the symbols I, X, C, and M can be repeated three times in succession, but no more." do
      context "example I that can repeat 3 times" do
        let(:text) { "how much is glob glob glob ?" }
        
        it "example I that can repeat 3 times" do
          is_expected.to eq "glob glob glob is 3"
        end
      end
      
      context "fails when I is repeated 4 times" do
        let(:text) { "how much is glob glob glob glob ?" }

        it "fails when I is repeated 4 times" do
          expect { subject }.to raise_error(Conversion::Calculator::RepeatedTooManyTimesError)
        end
      end

      context "processes random text" do
        let(:text) { "how much wood could a woodchuck chuck if a woodchuck could chuck wood" }

        it "fails when I is repeated 4 times" do
          is_expected.to eq "I have no idea what you are talking about"
        end
      end
    end
  end
end