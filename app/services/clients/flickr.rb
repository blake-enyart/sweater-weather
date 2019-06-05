class Clients::Flickr
  def initialize(city, state)
    @city = city
    @state = state
  end

  include Api::Flickr

  def find_photo_info
    get_json({method: 'flickr.photos.search',
              api_key: ENV['flickr_api_key'],
              per_page: 1,
              format: 'json',
              safe_search: 1,
              content_type: 1,
              tags: "#{city},#{state},skyline,city",
              license: '2,3,4,5,6,9',
              sort: 'relevance',
              nojsoncallback: 1
              })[:photos][:photo][0]
  end

  def generate_url
    results = find_photo_info
    "https://farm#{results[:farm]}.staticflickr.com/#{results[:server]}/#{results[:id]}_#{results[:secret]}.jpg"
  end

  private
    attr_reader :city, :state
end
