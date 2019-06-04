class Api::V1::FavoritesController < ApplicationController
  def create
    location = Location.find(params[:location])
    if (current_user.api_key == params[:api_key]) && params[:api_key]
      FavoriteLocation.create(user: current_user, location: location)
      render status: 201, json: {} # Need to know where to redirect this
    else
      render status: 401, json: {} # Need to build render || redirect path
    end
  end
end
