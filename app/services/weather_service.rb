class WeatherService
  attr_reader :city, :state

  def initialize(location)
    location = location.split(',')
    @city = location[0].titleize
    @state = location[1].upcase
  end

  def geocoded_location
    geocode = Clients::GoogleMaps.new(city, state)
    coordinates ||= geocode.coordinates
    unless Location.find_by(latitude: coordinates[:latitude], longitude: coordinates[:longitude])
      Location.create(city: city, state: state,
                      latitude: coordinates[:latitude],
                      longitude: coordinates[:longitude])
    end
    coordinates
  end

  def next_week
    dark_sky = Clients::DarkSky.new(geocoded_location)
    dark_sky.get_weather
  end
end
