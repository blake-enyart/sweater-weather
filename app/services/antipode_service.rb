class AntipodeService
  attr_reader :city

  def initialize(city)
    city = city[0..3] + ' ' + city[4..-1]
    city = city.titleize
    @city = city
  end

  def geocoded_location
    Rails.cache.fetch(city) {
      geocode.coordinates
    }
  end

  def get_antipode
    amypode = Clients::Amypode.new(geocoded_location)
    amypode.get_antipode_coordinates
  end

  def antipode_name
    antipode
    .reverse_geocode
  end

  def geocode
    @_geocode ||= Clients::GoogleMaps.new(city, nil)
  end
end
