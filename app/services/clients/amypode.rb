class Clients::Amypode
  include Api::Amypode

  def initialize(coordinates)
    @coordinates = coordinates
  end

  def antipode_coordinates
    results = get_json('antipodes', {lat: coordinates[:latitude], long: coordinates[:longitude]})
    {latitude: results[:data][:attributes][:lat],
    longitude: results[:data][:attributes][:long]}
  end

  private

    attr_reader :coordinates
end
