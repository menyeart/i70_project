class ForecastFacade
  def initialize(direction)
    @direction = direction
    @resort_object_hash = Hash.new { |h, k| h[k] = h.dup.clear }
    # real one
    # @today_seconds = (Date.today.to_time - "1970-01-01T00:00:00Z".to_date.to_time).to_i + 25200
    @today_seconds = (Date.today.to_time - "1970-01-01T00:00:00Z".to_date.to_time).to_i + 50000
    @departure_times = [@today_seconds + 19800, @today_seconds + 20700, @today_seconds + 21600, @today_seconds + 22500, @today_seconds + 23400, @today_seconds + 24300, @today_seconds + 25200, @today_seconds + 26100, @today_seconds + 27000, @today_seconds + 27900, @today_seconds + 28800 ]
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
  end

  def format_location_id(id)
    "place_id:" + id
  end

  def choose_direction
    @direction == "west" ? to_resort_times : to_golden_times
  end

  # def to_golden_times
  # end
end