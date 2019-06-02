class Clients::GoogleMaps
  include Api::GoogleGeocode

  def initialize(city, state)
    @city = city
    @state = state
  end

  def coordinates
    response = Api::GoogleGeocode.get_json('geocode/json', city, state)
    latitude = response[:results][0][:geometry][:location][:lat]
    longitude = response[:results][0][:geometry][:location][:lng]
    { longitude: longitude, latitude: latitude }
  end

  private
    attr_reader :city, :state
end
