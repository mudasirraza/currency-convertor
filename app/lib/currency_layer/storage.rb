module CurrencyLayer
  class Storage
    def initialize(raw_data)
      @raw_data = raw_data
    end

    def save
      parser = CurrencyLayer::Parser.new(@raw_data)
      if parser.valid?
        Rate.insert_all(parser.parsed_data)
      else
        Rails.logger.error 'CurrencyLayer::Storage invalid data: ' + @raw_data
      end
    end

    def self.serialzied_rates
      return @serialzied_rates if @serialzied_rates.present?

      @serialzied_rates = {
        'source': CurrencyLayer.source,
        'timestamp': Time.now.to_i,
        'quotes': Rate.latest.map { |rate| ["#{rate.from_currency}#{rate.to_currency}", rate.rate.to_f] }.to_h
      }.to_json
    end
  end
end