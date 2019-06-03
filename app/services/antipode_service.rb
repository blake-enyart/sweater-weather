class AntipodeService
  def initialize(city)
    city = city[0..3] + ' ' + city[4..-1]
    city = city.titleize
    @city = city
  end

  def geocoded_location(city)
    city.coordinates
  end

  def get_antipode_coordinates
    Clients::Amypode.coordinates(geocoded_location(city))
  end

  def antipode_name
    results = geocode.reverse_geocode(get_antipode)
    city = results[:results][0][:address_components][1][:long_name]
    country = results[:results][0][:address_components][2][:long_name]
    "#{city}, #{country}"
  end

  def antipode_weather
    antipode_city = Clients::GoogleMaps.new(antipode_name[0], antipode_name[1])
    antipode_coordinates = antipode_city.coordinates
    require "pry"; binding.pry
  end

  def antipode_city
    @_antipode_city ||= Clients::GoogleMaps.new(antipode_name)
  end

  def city
    @_city ||= Clients::GoogleMaps.new(city, nil)
  end
end
