require "rails_helper"

RSpec.describe DurationService do
  before(:each) do
    @service = DurationService.new(100000009000)
  end

  describe "exists and has an api call", :vcr do
    it "is a service" do
      expect(@service).to be_a(DurationService)
    end

    it "has a connection to faraday" do
      expect(@service.conn).to be_a(Faraday::Connection)
    end

    it "takes destination params and returns durations for each destination" do
      result = @service.durations

      expect(result).to be_a(Hash)
      expect(result).to have_key(:destination_addresses)
      expect(result[:destination_addresses]).to be_a(Array)
      expect(result).to have_key(:origin_addresses)
      expect(result[:origin_addresses]).to be_a(Array)
      expect(result).to have_key(:rows)
      expect(result[:rows]).to be_an(Array)
    end
  end
end