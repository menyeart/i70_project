require "rails_helper"

RSpec.describe DurationService do
  before(:each) do
    time = Time.local(2024, 9, 16, 4, 0, 0)
    Timecop.travel(time)
    # Need elapsed seconds since Jan 1 1970, to the start(midnight) of the current day, plus however many seconds for each start destination(5:30 -9:00 in 15 min increments)
    today_at_time = (Date.today.to_time - "1970-01-01T00:00:00Z".to_date.to_time + 25200 + 28800 + 50000).to_i
    destination = "place_id:ChIJtzbUKLpCFYcRGpheZl7SdZw"
    @service = DurationService.new(today_at_time, destination)
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