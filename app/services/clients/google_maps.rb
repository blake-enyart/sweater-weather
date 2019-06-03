class Clients::GoogleMaps
  include Api::GoogleGeocode

  def initialize(city, state)
    @city = city
    @state = state
  end

  def coordinates
    response = get_json('geocode/json', city, state)
    latitude = response[:results][0][:geometry][:location][:lat]
    longitude = response[:results][0][:geometry][:location][:lng]
    { longitude: longitude, latitude: latitude }
  end

  def reverse_geocode
    raw_coordinates = "#{coordinates[:latitude]},#{coordinates[:longitude]}"
    response = get_json('geocode/json', city, state, {latlng: raw_coordinates})
    require "pry"; binding.pry
  end

  private
    attr_reader :city, :state
end
