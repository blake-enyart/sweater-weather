class Api::V1::AntipodeController < ApplicationController
  def index
    antipode_service = AntipodeService.new(params[:loc])
    render json: AntipodeSerializer.parse(antipode_service.all_data)
  end
end
