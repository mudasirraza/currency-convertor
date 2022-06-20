require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DashboardHelper. For example:
#
# describe DashboardHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe DashboardHelper, type: :helper do
  describe 'base_currency' do
    it 'returns base_currency value' do
      expect(helper.base_currency).to eq(StaticData::BASE_CURRENCY)
    end
  end

  describe 'to_currencies' do
    it 'returns to_currencies value' do
      expect(helper.to_currencies).to eq(StaticData::TO_CURRENCIES)
    end
  end
end
