class Api::V1::ForecastController < ApplicationController
  def index
    render json: DarkSkyService.new(params[:location])
  end
end
