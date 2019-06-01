class DarkSkyService
  attr_reader :city, :state

  def initialize(location)
    location = location.split(',')
    @city = location[0]
    @state = location[1]
  end

  def geocoded_location
    geocode = Clients::Geocoding.new(city, state)
    geocode.coordinates
  end
end
