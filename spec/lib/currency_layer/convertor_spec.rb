require 'rails_helper'

RSpec.describe CurrencyLayer::Convertor do
  describe 'validation' do
    it 'is not valid if to_currency or input_number is not present' do
      convertor = described_class.new
      expect(convertor.valid?).to eq(false)
      expect(convertor.errors[:to_currency]).not_to be_empty
      expect(convertor.errors[:input_number]).not_to be_empty
    end
  end

  describe '.convert!' do
    it 'converts successfully from EUR to USD' do
      convertor = described_class.new(to_currency: 'USD', input_number: 1)
      expect(Money).to receive_message_chain(:from_amount, :exchange_to, :format)
        .with(1.to_d, 'EUR').with('USD').with({symbol_position: :after})
        .and_return(1.01)
      expect(convertor.convert!).to eq(1.01)
    end
  end
end
