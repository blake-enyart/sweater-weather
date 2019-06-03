class BackgroundService
  attr_reader :city, :state

  def initialize(location)
    location = location.split(',')
    @city = location[0].titleize
    @state = location[1].upcase
  end

  def get_photo_url
    flickr = Clients::Flickr.new(city, state)
    flickr.generate_url
  end
end
