class DurationService
  def initialize(departure_time, resort)
    @departure_time = departure_time
    @resort = resort
  end

  def conn
    Faraday.new(url: "https://maps.googleapis.com")
  end

  def durations
    get_url("maps/api/distancematrix/json?destinations=#{@resort}&origins=Golden, CO&units=imperial&key=#{ENV['goog_api']}&traffic_model=pessimistic&departure_time=#{@departure_time}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end