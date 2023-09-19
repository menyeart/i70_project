class ForecastSerializer
  include JSONAPI::Serializer
  attributes :date, :direction, :duration_info
end