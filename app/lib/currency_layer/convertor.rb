module CurrencyLayer
  class Convertor
    include ActiveModel::Model

    attr_accessor :to_currency, :input_number, :result
    attr_writer :from_currency

    validates :to_currency, :input_number, presence: true
    validates :to_currency, inclusion: { in: StaticData::TO_CURRENCIES }
    validates :input_number, numericality: { only_float: true }

    def from_currency
      @from_currency || StaticData::BASE_CURRENCY
    end

    def convert!
      begin
        @result = Money.from_amount(@input_number.to_d, from_currency).exchange_to(@to_currency).format(symbol_position: :after)
      rescue Money::Bank::Error => e
        errors.add(:base, e.message)
      end
    end
  end
end