class AntipodeService
  attr_reader :main_city

  def initialize(main_city)
    main_city = main_city[0..3] + ' ' + main_city[4..-1]
    main_city = main_city.titleize
    @main_city = main_city
  end

  def geocoded_location
    city.coordinates
  end

  def antipode_location
    amypode = Clients::Amypode.new(geocoded_location)
    amypode.antipode_coordinates
  end

  def antipode_name
    results = city.reverse_geocode(antipode_location)
    city = results[:results][0][:address_components][1][:long_name]
    country = results[:results][0][:address_components][2][:long_name]
    "#{city}, #{country}"
  end

  def antipode_weather
    antipode_city.
    require "pry"; binding.pry
  end

  def antipode_city
    @_antipode_city ||= Clients::GoogleMaps.new(antipode_name)
  end

  def city
    @_city ||= Clients::GoogleMaps.new(main_city, nil)
  end
end
