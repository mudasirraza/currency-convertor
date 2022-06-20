require 'rails_helper'

RSpec.describe CurrencyLayer::Parser do
  let(:raw_data) { File.read(File.join('spec', 'fixtures', 'sample.json')) }
  let(:parser) { described_class.new(raw_data) }

  describe '.parsed_data' do
    it 'returns parsed_data' do
      date = Date.parse('Tue, 01 Sep 2015')
      expect(parser.parsed_data).to eq(
        [
          {:from_currency=>"USD", :to_currency=>"AUD", :rate=>0.1413637e1, :date=>date}, 
          {:from_currency=>"USD", :to_currency=>"CAD", :rate=>0.1316495e1, :date=>date}, 
          {:from_currency=>"USD", :to_currency=>"CHF", :rate=>0.96355e0, :date=>date}, 
          {:from_currency=>"USD", :to_currency=>"EUR", :rate=>0.888466e0, :date=>date}, 
          {:from_currency=>"USD", :to_currency=>"BTC", :rate=>0.4322e-2, :date=>date}
        ]
      )
    end
  end

  describe '.valid?' do
    it 'returns true for a valid data' do
      expect(parser.valid?).to eq(true)
    end

    it 'returns false for an invalid data' do
      parser = described_class.new({})
      expect(parser.valid?).to eq(false)

      invalid_data = {
        "timestamp": 1441101909,
        "source": "USD",
      }
      parser = described_class.new(invalid_data)
      expect(parser.valid?).to eq(false)

      {
        "timestamp": 1441101909,
        "source": "USD",
        "quotes": {
            "USD": 1.413637,
            "EUR": 1.316495,
        }
      }
      parser = described_class.new(invalid_data)
      expect(parser.valid?).to eq(false)
    end
  end 
end
