class Clients::Amypode
  include Api::Amypode

  def initialize(coordinates)
    @longitude = coordinates[:longitude]
    @latitude = coordinates[:latitude]
  end

  def get_antipode_coordinates
    results = get_json('antipodes', {lat: latitude, long: longitude})
    {latitude: results[:data][:attributes][:lat],
    longitude: results[:data][:attributes][:long]}
  end

  private

    attr_reader :longitude, :latitude
end
