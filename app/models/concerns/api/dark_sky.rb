module Api::DarkSky
  private

    def conn
      Faraday.new('https://api.darksky.net/forecast/') do |f|
        f.headers['Content-Type'] = 'application/json'
        f.adapter  Faraday.default_adapter
      end
    end

    def get_json(latitude, longitude)
      response = conn.get("#{ENV['dark_sky_api_key']}/#{latitude},#{longitude}")
      JSON.parse(response.body, symbolize_names: true)
    end
end
