class Api::V1::AntipodeController < ApplicationController
  def index
    render json: AntipodeService.new(params[:loc])
  end
end
