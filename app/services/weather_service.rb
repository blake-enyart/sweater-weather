class WeatherService
  attr_reader :city, :state

  def initialize(location)
    location = location.split(',')
    @city = location[0].titleize
    @state = location[1].upcase
  end

  def geocoded_location
    geocode = Clients::GoogleMaps.new(city, state)
    # check database for location first
    location = Location.find_by(city: city, state: state)
    if location
      return { longitude: location.longitude, latitude: location.latitude }
    else
      coordinates ||= geocode.coordinates
      Location.create(city: city, state: state,
                      latitude: coordinates[:latitude],
                      longitude: coordinates[:longitude])
      coordinates
    end
  end

  def next_week
    dark_sky = Clients::DarkSky.new(geocoded_location)
    dark_sky.get_weather
  end
end
