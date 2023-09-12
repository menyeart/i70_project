require "rails_helper"

RSpec.describe DurationService do
  before(:each) do
    # Need elapsed seconds since Jan 1 1970, to the start(midnight) of the current day, plus however many seconds for each start destination

    # Date.today.to_time - "1970-01-01T00:00:00Z".to_date.to_time

    # 5 hours : 18000
    # 15 min : 900

    # 5:30 19800
    # 5:45 20700
    # 6:00 21600
    # 6:15 22500
    # 6:30 23400
    # 6:45 24300
    # 7:00 25200
    # 7:15 26100
    # 7:30 27000
    # 7:45 27900
    # 8:00 28800
    # 10:00 36000
    # UTC adder 25200 (gets you to midnight)

    today_at_time = (Date.today.to_time - "1970-01-01T00:00:00Z".to_date.to_time + 25200 + 28800 + 1800).to_i

    @service = DurationService.new(today_at_time)
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
      binding.pry

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