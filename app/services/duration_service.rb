class DurationService
  def initialize(departure_time)
    @departure_time = departure_time
  end

  def conn
    Faraday.new(url: "https://maps.googleapis.com")
  end

  def durations
    get_url("maps/api/distancematrix/json?destinations=place_id:ChIJDW4E2OtRaocR6Ny-eVsZRyY|place_id:ChIJy0LIeaDKa4cRW2sSTH03-bU|place_id:ChIJe2Rv9PdfaocR-3_TarNZh2M&origins=Golden, CO&units=imperial&key=#{ENV['goog_api']}&traffic_model=pessimistic&departure_time=#{@departure_time}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end