class AntipodeService
  attr_reader :city

  def initialize(city)
    city = city[0..3] + ' ' + city[4..-1]
    city = city.titleize
    @city = city
  end
end
