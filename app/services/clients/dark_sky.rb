class Clients::DarkSky
  include Api::DarkSky

  def initialize(coordinates)
    @longitude = coordinates[:longitude]
    @latitude = coordinates[:latitude]
  end

  def get_weather
    get_json(latitude, longitude)
  end

  private

    attr_reader :latitude, :longitude
end
