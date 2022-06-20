module CurrencyLayer
  class Parser
    def initialize(raw_data)
      @raw_data = raw_data
      @rates = []
    end

    def parsed_data
      return @rates if @rates.present?

      @rates = (parsed_json['quotes'] || {}).map do |k, v|
        {
          from_currency: k[0..2] || parsed_json['source'],
          to_currency: k[3..-1],
          rate: v.to_d,
          date: Time.at(parsed_json['timestamp']).to_date
        }
      end
    end

    def valid?
      return false if parsed_json['quotes'].blank? || parsed_json['timestamp'].blank?

      parsed_data unless @rates.present?
      @rates.all? { |rate| Rate.new(rate).valid? }
    end

    private

    def parsed_json
      @parsed_json ||= JSON.parse(@raw_data.to_s)
    rescue JSON::ParserError
      {}
    end
  end
end
