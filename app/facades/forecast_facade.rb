class ForecastFacade
  def initialize(direction)
    @direction = direction
    @resort_object_hash = Hash.new { |h, k| h[k] = h.dup.clear }
    @today_seconds = (Date.today.to_time - "1970-01-01T00:00:00Z".to_date.to_time).to_i + 25200
    @departure_times = calculate_departure_times
    @all_ski_areas = SkiArea.all
  end

  def create_forecast
    @all_ski_areas.each do |area|
      @departure_times.each do |time|
        data = DurationService.new(time, format_location_id(area.location_id)).durations
        @resort_object_hash[area.name][time]["duration"] = data[:rows].first[:elements].first[:duration][:value]
        @resort_object_hash[area.name][time]["duration_with_traffic"] = data[:rows].first[:elements].first[:duration_in_traffic][:value]
      end
    end
    Forecast.new("west", @resort_object_hash)
  end

  def format_location_id(id)
    "place_id:" + id
  end

  def choose_direction
    @direction == "west" ? to_resort_times : to_golden_times
  end

  def calculate_departure_times
    time = @today_seconds + 19800
    times = [time]
    10.times do
      time += 900
      times << time
    end
    times
  end
end