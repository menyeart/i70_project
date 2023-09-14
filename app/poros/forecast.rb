class Forecast
  def initialize(date, direction, duration_info)
    @date = Date.today
    @direction = direction
    @duration_info = duration_info
  end
end