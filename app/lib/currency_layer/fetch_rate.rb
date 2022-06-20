module CurrencyLayer
  class FetchRate
    def self.run(straight: true)
      begin
        CurrencyLayer.update_rates(straight)
      rescue => e
        Rails.logger.error e.inspect
      end
    end

    def self.initial_run
      if Rate.where('date >= ?', 2.days.ago).blank?
        run
      else
        run(straight: false)
      end
    end
  end
end