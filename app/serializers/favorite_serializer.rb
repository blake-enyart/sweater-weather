class FavoriteSerializer

  def self.parse(favorite_locations)
    weather_data = []
    favorite_locations.each do |location|
      hash = {}
      weather = WeatherService.new(location)
      today_forecast = WeatherSerializer.parse(weather.next_week)[:today_forecast]
      hash[:location] = location
      hash[:today_forecast] = today_forecast
      weather_data << hash
    end
    weather_data
    require "pry"; binding.pry
  end
end
