class Api::V1::ForecastController < ApplicationController
  def index
    render json: WeatherService.new(params[:location])
  end
end
