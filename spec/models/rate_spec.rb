require 'rails_helper'

RSpec.describe Rate, type: :model do
  describe 'validation' do
    it 'returns errors for empty attributes' do
      expect(subject.valid?).to eq(false)
      expect(subject.errors[:from_currency]).not_to be_empty
      expect(subject.errors[:to_currency]).not_to be_empty
      expect(subject.errors[:rate]).not_to be_empty
      expect(subject.errors[:date]).not_to be_empty
    end

    it 'validates valid attributes' do
      rate = described_class.new(from_currency: 'EUR', to_currency: 'USD', rate: 1.2.to_d, date: Date.today)
      expect(rate.valid?).to eq(true)
    end
  end
end
