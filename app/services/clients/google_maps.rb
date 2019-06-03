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

  def reverse_geocode(antipode_coordinates)
    raw_coordinates = "#{antipode_coordinates[:latitude]},#{antipode_coordinates[:longitude]}"
    get_json('geocode/json', {latlng: raw_coordinates})
  end

  private
    attr_reader :city, :state
end
