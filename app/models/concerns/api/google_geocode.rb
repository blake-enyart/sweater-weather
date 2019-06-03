module Api::GoogleGeocode
  private

    def conn
      Faraday.new('https://maps.googleapis.com/maps/api/') do |f|
        f.params['key'] = ENV['google_geocoding_key']
        f.adapter  Faraday.default_adapter
      end
    end

    def get_json(url, options=nil)
      response = conn.get(url, options)
      JSON.parse(response.body, symbolize_names: true)
    end
end
