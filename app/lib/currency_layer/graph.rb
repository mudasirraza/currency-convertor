module CurrencyLayer
  class Graph
    include ActiveModel::Model

    attr_accessor :to_currency, :result
    attr_writer :from_currency, :date_after

    validates :to_currency, presence: true, inclusion: { in: StaticData::TO_CURRENCIES }

    def from_currency
      @from_currency || StaticData::BASE_CURRENCY
    end

    def date_after
      @date_after || Date.parse('2019-10-17') - 7.days #for rates.json
    end

    def setup_graph_data!
      rates = Rate.date_after(date_after).with_from_currency(from_currency).with_to_currency(to_currency).order(:date)
      graph_data = rates.map { |rate| [rate.date, rate.rate] } if rates.present?

      @result = [
        name: "#{from_currency} to #{to_currency}",
        data: graph_data
      ]
    end
  end
end