require 'money/bank/currencylayer_bank'
require Rails.root.join('lib', 'currency_layer')

CurrencyLayer.configure do |config|
  mclb = Money::Bank::CurrencylayerBank.new
  mclb.access_key = ENV['CURRENCYLAYER_ACCESS_KEY']
  mclb.source = 'USD'
  mclb.ttl_in_seconds = 31556952 # 1.year
  mclb.cache = Proc.new do |v|
    if v.present?
      CurrencyLayer::Storage.new(v).save
    else
      CurrencyLayer::Storage.serialzied_rates
    end
  end
  Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN
  config.default_bank = mclb
end

CurrencyLayer::FetchRate.initial_run unless Rails.env.test?