class Clients::Amypode
  def initialize(coordinates)
    @longitude = coordinates[:longitude]
    @latitude = coordinates[:latitude]
  end

  def get_antipode
    get_json('antipodes', coordinates)
  end

  private

    attr_reader :longitude, :latitude

    def conn
      Faraday.new('http://amypode.herokuapp.com/api/v1/') do |f|
        f.headers['api_key'] = ENV['amypode_api_key']
        f.adapter  Faraday.default_adapter
      end
    end

    def get_json(url, options)
      response = conn.get(url, options)
      require "pry"; binding.pry
      JSON.parse(response.body, symbolize_names: true)
    end
end
