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

  def index
    if (current_user.api_key == params[:api_key]) && params[:api_key]
      render status: 200, json: FavoriteSerializer.parse(current_user.fav_city_names)
    else
      render status: 401, json: {}
    end
  end

  def destroy
    if (current_user.api_key == params[:api_key]) && params[:api_key]
      favorite_location = FavoriteLocation.find_by(user_id: current_user.id, location_id: params[:location])
      favorite_location.delete
      render status: 200, json: FavoriteSerializer.parse(current_user.fav_city_names)
    else
      render status: 401, json: {}
    end
  end
end
