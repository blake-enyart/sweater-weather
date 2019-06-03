class Api::V1::BackgroundsController < ApplicationController
  def index
    background_service = BackgroundService.new(params[:location])
    render json: BackgroundSerializer.parse(background_service.get_photo_url)
  end
end
