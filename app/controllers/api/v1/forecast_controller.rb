class Api::V1::ForecastController < ApplicationController
  def index
    forecast = ForecastFacade.new(params[:direction]).create_forecast
  end
end