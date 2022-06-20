module CurrencyLayer
  module Configuration
    def configure
      yield self
    end

    attr_reader :default_bank

    def default_bank=(bank)
      Money.default_bank = bank
      @default_bank = bank
    end
  end
end
