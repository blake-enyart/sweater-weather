module Api::Amypode
  private

    def conn
      Faraday.new('http://amypode.herokuapp.com/api/v1/') do |f|
        f.headers['api_key'] = ENV['amypode_api_key']
        f.adapter  Faraday.default_adapter
      end
    end

    def get_json(url, options)
      response = conn.get(url, options)
      JSON.parse(response.body, symbolize_names: true)
    end
end
