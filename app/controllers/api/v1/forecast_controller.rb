class Api::V1::ForecastController < ApplicationController
  def index
    weather = WeatherService.new(params[:location])
    render json: WeatherSerializer.parse(weather.next_week)
  end
end
