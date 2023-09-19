class Forecast
  attr_reader :direction, :date, :duration_info, :id
  def initialize(direction, duration_info)
    @id = 1
    @date = Date.today
    @direction = direction
    @duration_info = duration_info
  end
end