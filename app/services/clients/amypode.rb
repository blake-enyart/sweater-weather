class Clients::Amypode
  def initialize(coordinates)
    @longitude = coordinates[:longitude]
    @latitude = coordinates[:latitude]
  end

  def get_antipode

  end

  private

    attr_reader :latitude, :longitude
end
