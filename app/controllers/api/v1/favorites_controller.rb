class Api::V1::FavoritesController < ApplicationController
  def create
    request_info = JSON.parse(request.body.read, symbolize_names: true)
    city_state = request_info[:location].split(',').map do |element|
      element.strip
    end
    location = Location.find_by(city: city_state[0].titleize, state: city_state[1].upcase)
    user = User.find_by(api_key: request_info[:api_key])
    if user && request_info[:api_key]
      FavoriteLocation.create(user: user, location: location)
      render status: 201, json: { success: "Added #{location.city} to #{user.email} favorites." } # Need to know where to redirect this
    else
      render status: 401, json: { error: "Invalid credentials." } # Need to build render || redirect path
    end
  end

  def index
    request_info = JSON.parse(request.body.read, symbolize_names: true)
    user = User.find_by(api_key: request_info[:api_key])
    if user && request_info[:api_key]
      render status: 200, json: FavoriteSerializer.parse(user.fav_city_names)
    else
      render status: 401, json: { error: "Invalid credentials." }
    end
  end

  def destroy
    request_info = JSON.parse(request.body.read, symbolize_names: true)
    user = User.find_by(api_key: request_info[:api_key])
    city_state = request_info[:location].split(',').map do |element|
      element.strip
    end
    location = Location.find_by(city: city_state[0].titleize, state: city_state[1].upcase)
    if user && request_info[:api_key]
      favorite_location = FavoriteLocation.find_by(user_id: user.id, location_id: location)
      favorite_location.delete
      render status: 200, json: FavoriteSerializer.parse(user.fav_city_names)
    else
      render status: 401, json: { error: "Invalid credentials." }
    end
  end
end
