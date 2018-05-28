RSpec.describe TextInput::Answer do
  describe ".parse" do
    subject { described_class.parse(text) }

    context "how much" do
      let(:text) { "how much is pish tegj glob glob ?" }
      let(:extracted_text) { "pish tegj glob glob" }
      let(:stub_value) { 11 }

      it "removes unwanted words and calls Conversion" do
        expect(Conversion).to receive(:parse).with(extracted_text).and_return(stub_value)
        is_expected.to eq "#{extracted_text} is #{stub_value}"
      end
    end

    context "how many" do
      let(:text) { "how many Credits is glob prok Silver ?" }
      let(:extracted_text) { "glob prok" }
      let(:stub_convertion_result) { 11 }

      before do
        Currency::add_exchange_rate(name: :gold, value: 2)
        Currency::add_exchange_rate(name: :silver, value: 20)
        Currency::add_exchange_rate(name: :iron, value: 200)
      end

      it "removes unwanted words and calls Conversion" do
        expect(Conversion).to receive(:parse).with(extracted_text).and_return(stub_convertion_result)
        is_expected.to eq "#{extracted_text} silver is 220 Credits"
      end
    end
  end
end
