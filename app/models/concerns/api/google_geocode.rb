module Api::GoogleGeocode
  private

    def self.conn
      Faraday.new('https://maps.googleapis.com/maps/api/') do |f|
        f.params['key'] = ENV['google_geocoding_key']
        f.adapter  Faraday.default_adapter
      end
    end

    def self.get_json(url, city, state)
      response = conn.get(url) do |f|
        f.params['address'] = "#{city},+#{state}"
      end
      JSON.parse(response.body, symbolize_names: true)
    end
end
