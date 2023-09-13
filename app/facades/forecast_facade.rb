class ForecastFacade
  def initialize(direction)
    @direction = direction
    @resort_object_hash = {}
    @today_seconds = (Date.today.to_time - "1970-01-01T00:00:00Z".to_date.to_time).to_i + 25200
    @departure_times = [@today_seconds + 19800, @today_seconds + 20700, @today_seconds + 21600, @today_seconds + 22500, @today_seconds + 23400, @today_seconds + 24300, @today_seconds + 25200, @today_seconds + 26100, @today_seconds + 27000, @today_seconds + 27900, @today_seconds + 28800 ]
    @resort_names_list = SkiArea.all.select(:name)
  end

  def create_forecast
    @departure_times.each do |time|
      DurationService.new(time, ski_resort_list)
    
    end
  end

  def choose_direction
    @direction == "west" ? to_resort_times : to_golden_times
  end

  def ski_resort_list
    SkiArea.all.map { |resort| ("place_id:#{resort.location_id}|") }.join("").chop
  end


  def to_golden_times

  end
end