class WeatherService
  attr_reader :city, :state

  def initialize(location)
    location = location.split(',')
    @city = location[0].titleize
    @state = location[1].upcase
  end

  def geocoded_location
    geocode = Clients::GoogleMaps.new(city, state)
    Rails.cache.fetch("#{city},#{state}") {
      geocode.coordinates
    }
  end

  def next_week
    dark_sky = Clients::DarkSky.new(geocoded_location)
    dark_sky.get_weather
  end
end
