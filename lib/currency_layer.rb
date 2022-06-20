require Rails.root.join('lib', 'currency_layer', 'configuration')

module CurrencyLayer
  extend Configuration

  class << self
    delegate_missing_to :default_bank
  end
end