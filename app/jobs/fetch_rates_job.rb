class FetchRatesJob < ApplicationJob

  def run
    CurrencyLayer::FetchRate.run
  end
end
